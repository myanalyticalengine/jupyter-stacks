VERSION = 1.0.0

.PHONY: base-notebook
base-notebook:
	cd base-notebook && podman build -t jupyter-stacks/base-notebook:${VERSION} .