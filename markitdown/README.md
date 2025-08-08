# MarkItDown

MarkItDown is a tool for converting PDF files to Markdown format. It allows you to extract the content of PDF documents and output them as Markdown, making it easier to edit, share, or repurpose your documents.

For more details about features and capabilities, visit the [official MarkItDown repository](https://github.com/microsoft/markitdown).

## Usage

You can run MarkItDown using Docker. The following command reads a PDF file and outputs the converted Markdown:

```sh
docker run --rm -i ottijp/markitdown:latest \
  < ./file.pdf \
  > file.md
```

## References

- [MarkItDown GitHub Repository](https://github.com/microsoft/markitdown)
- [Docker Hub - MarkItDown](https://hub.docker.com/r/ottijp/markitdown)
