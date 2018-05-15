FROM alpine:3.5 AS build
RUN apk update && apk add --update alpine-sdk
RUN mkdir /app
WORKDIR /app
COPY hello.c /app
RUN mkdir bin
RUN gcc -Wall hello.c -static -o bin/hello
CMD /app/bin/hello

FROM scratch 
COPY --from=build /app/bin/hello /app/hello
CMD /app/hello
