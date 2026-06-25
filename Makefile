PROTO_ROOT := proto
OUT := gen/go
PROTO_FILES := $(shell find $(PROTO_ROOT) -name '*.proto')

.PHONY: generate clean tidy

# Generate Go gRPC stubs with protoc (no buf required).
generate:
	@mkdir -p $(OUT)
	protoc \
		--proto_path=$(PROTO_ROOT) \
		--go_out=$(OUT) --go_opt=paths=source_relative \
		--go-grpc_out=$(OUT) --go-grpc_opt=paths=source_relative \
		$(PROTO_FILES)
	@$(MAKE) tidy

# Alternative: `buf generate` if buf is installed (uses buf.gen.yaml).
buf:
	buf generate

tidy:
	go mod tidy

clean:
	rm -rf $(OUT)
