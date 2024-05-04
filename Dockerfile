FROM python:3.11-slim
WORKDIR /web
COPY . .
EXPOSE 5000
RUN pip install flask gunicorn
CMD gunicorn -b 0.0.0.0 app:app

Описание задания

restart-docker-compose:
  runs-on: ubuntu-latest
  needs: build-deploy
  steps:
    - name: Run remote script with SSH
      uses: appleboy/ssh-action@v1.0.3
      with:
        host: ${{ secrets.HOST }}
        username: ${{ secrets.USERNAME }}
        key: ${{ secrets.KEY }}
        script: |
         cd $HOME
         docker compose down
         docker pull ghcr.io/${{ github.repository }}:main
         docker compose up -d
