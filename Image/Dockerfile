FROM alpine:latest

RUN apk add --no-cache python3-dev && pip3 install --upgrade pip

WORKDIR /app

COPY requirements.txt /app

RUN pip3 --no-cache-dir install -r requirements.txt

COPY . /app

EXPOSE 3000

ENTRYPOINT ["python3","app.py"]
