# Version de Python choisie à la construction : docker build --build-arg RUNTIME=3.11 .
ARG RUNTIME=3.11

# ---------- Stage 1 : builder (installe les dépendances) ----------
FROM python:${RUNTIME}-slim AS builder
WORKDIR /build
COPY app/requirements.txt .
RUN pip install --no-cache-dir --prefix=/install -r requirements.txt

# ---------- Stage 2 : image finale (légère) ----------
FROM python:${RUNTIME}-slim
ARG RUNTIME
LABEL runtime="${RUNTIME}"
WORKDIR /app
COPY --from=builder /install /usr/local
COPY app/ .
EXPOSE 5000
CMD ["python", "app.py"]