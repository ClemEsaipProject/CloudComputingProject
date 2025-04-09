# Étape de build
FROM python:3.9-slim as builder
COPY requirements.txt .
RUN pip install --user -r requirements.txt

# Étape finale
FROM python:3.9-slim
WORKDIR /app
COPY --from=builder /root/.local /root/.local
COPY . .
ENV PATH=/root/.local/bin:$PATH
EXPOSE 5000
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]
