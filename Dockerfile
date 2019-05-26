FROM ponylang/ponyc

COPY . /src/main/

CMD "./runTests"
