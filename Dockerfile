FROM python:3.7.6-slim as python
ENV PYTHONUNBUFFERED=true
WORKDIR /app

FROM python:3.7.6 as poetry
WORKDIR /app
ENV POETRY_HOME=/opt/poetry
ENV POETRY_VIRTUALENVS_IN_PROJECT=true
ENV PATH="$POETRY_HOME/bin:$PATH"
RUN python -c 'from urllib.request import urlopen; print(urlopen("https://install.python-poetry.org").read().decode())' | python -
COPY . ./
RUN poetry install --no-interaction --no-ansi -vvv

FROM python:3.7.6 as runtime
ENV PATH="/app/.venv/bin:$PATH"
CMD ["python", "-m", "callisto"]
COPY --from=poetry /app /app
