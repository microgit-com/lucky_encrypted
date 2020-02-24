# lucky_encrypted

An type for Lucky framework Avram that's encrypt a string before saving to a database and decrypts when getting it from db.

it use defaults from Lucky's message encryptor class, which is using when last checked `aes-256-cbc` and the digest is `sha1`

You only need one column, as both the iv and the data is saved in one, splitted.

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     lucky_encrypted:
       github: microgit-com/lucky_encrypted
   ```

2. Run `shards install`

## Usage

* ```crystal
require "lucky_encrypted"
```
* add `require "lucky_encrypted"` in shards.cr
* Create an column for the encrypted string you want to save with lucky migration, i use `otp_secret` as example.
* create a secret for the encryption with `lucky gen.secret_key`
* add it with dotenv or what ever you use, or just set environment for `ENCRYPTED_SECRET`

* Add the type `LuckyEncrypted::StringEncrypted` as type for that column in the model:

  ```
    column otp_secret : LuckyEncrypted::StringEncrypted
  ```

it shall now work. (famous last words)

## Development

using stdlib spec and all. so just use the test and so forth.

## Contributing

1. Fork it (<https://github.com/microgit-com/lucky_encrypted/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Håkan Nylén](https://github.com/confact) - creator and maintainer
