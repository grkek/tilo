To run the example and use it as intended you will need to first:

1. Install dependencies

```bash
shards install
./bin/gi-crystal
```

2. Run the HTTP API server and keep it running

```bash
make api
```

3. Run the GUI example (run two of them to have a little chat with yourself)

```bash
make build && make run
```

4. Build the GUI example and watch for changes usign Nodemon (Optional)

```bash
make watch
```