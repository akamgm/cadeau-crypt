:- module(secret, [gen_url/2]).

:- use_module(library(crypto)).
:- use_module(library(http/json)).
:- use_module(library(base64)).
:- use_module(library(uri)).

% Change this key and base url for your site
key('1532f0ea6770160c262a506df064c361').
base_url("https://santa.val.run/").

encrypt_atoms(Atom1, Atom2, HexKey, UrlToken) :-
    % A. Convert the Hex Key string back to bytes
    hex_bytes(HexKey, KeyBytes),

    % B. Create JSON payload
    Payload = _{ giver: Atom1, receiver: Atom2 },
    atom_json_dict(JsonString, Payload, []),

    % C. Generate a 96-bit (12-byte) IV
    crypto_n_random_bytes(12, IVBytes),

    % D. Encrypt using specific AES-128-GCM algorithm
    % CHANGED: 'AES-GCM' -> 'aes-128-gcm'
    crypto_data_encrypt(JsonString, 'aes-128-gcm', KeyBytes, IVBytes, CipherBytes, [tag(TagBytes)]),

    % E. Encode binary parts to Base64
    % Ensure no newlines get inserted (line_length(0)), otherwise JS atob fails
    base64_encoded(IVBytes, IV64, [encoding(octet), line_length(0)]),
    base64_encoded(CipherBytes, Cipher64, [encoding(octet), line_length(0)]),
    base64_encoded(TagBytes, Tag64, [encoding(octet), line_length(0)]),

    % F. Create wrapper object
    Wrapper = _{ iv: IV64, data: Cipher64, tag: Tag64 },
    atom_json_dict(WrapperJson, Wrapper, []),

    % G. URL Encode
    base64_encoded(WrapperJson, Base64Wrapper, [encoding(octet), line_length(0)]),
    uri_encoded(query_value, Base64Wrapper, UrlToken).

gen_url([Giver, Receiver], [Giver, Url]) :-
    base_url(Base),
    key(Key),
    encrypt_atoms(Giver, Receiver, Key, Slug),
    atom_concat(Base, Slug, Url).