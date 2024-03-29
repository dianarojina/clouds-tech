FROM python:3.11-slim
WORKDIR /web
COPY . .
EXPOSE 5000
RUN pip install flask gunicorn
CMD gunicorn -b 0.0.0.0 app:app

Описание задания
  build-deploy:
    runs-on: ubuntu-latest
    needs: testing
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Login to GitHub Container Registry
        uses: docker/login-action@v3
        with:
          registry: ghcr.io
          username: ${{ github.actor }}
          password: ${{ secrets.GITHUB_TOKEN }}

      - name: Build and push
        uses: docker/build-push-action@v5
        with:
          push: true
          tags: ${{ github.actor }}/students:latest
