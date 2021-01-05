## Postgres short id

Add the `gen_shortid()` function, which by default generates an id with 7 bytes of entropy.

You can specify the number of bytes of entropy by passing an argument: `gen_shortid(7)`.

### Docker build

Run `docker build .` to build the image. Then `docker tag <image-name> <published-name>` and `docker push <published-name>` to publish it.
