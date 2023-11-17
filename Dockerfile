FROM python:3.11-alpine

RUN apk add --update --no-cache --virtual .tmp-build-deps \
    gcc libc-dev linux-headers postgresql-dev \
    && apk add libffi-dev

# Install poetry separated from system interpreter
RUN pip3 install poetry

WORKDIR /app

# Install dependencies
COPY poetry.lock pyproject.toml ./
RUN poetry install

# Run your app
COPY . /app

EXPOSE 8000
ENV PORT 8000

CMD [ "poetry", "run", "gunicorn", "run:app" ]
