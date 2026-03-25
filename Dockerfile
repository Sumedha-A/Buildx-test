FROM alpine:3.19 AS build
RUN apk add --no-cache curl wget
RUN echo "build stage output" > /build-artifact.txt
RUN echo "additional build step" >> /build-artifact.txt

FROM alpine:3.19
RUN apk add --no-cache ca-certificates tini
COPY --from=build /build-artifact.txt /app/artifact.txt
RUN echo "deploy stage" > /app/status.txt
USER 1000
ENTRYPOINT ["cat", "/app/artifact.txt"]
