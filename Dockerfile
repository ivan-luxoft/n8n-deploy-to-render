# Dockerfile для n8n на Render.com
FROM n8nio/n8n:latest

# Установка временной зоны (опционально)
ENV TZ=Europe/Moscow

# Рабочая директория
WORKDIR /data

# Создание пользователя n8n (если не существует)
USER root
RUN if ! id -u n8n > /dev/null 2>&1; then \
        addgroup -g 1000 n8n && \
        adduser -u 1000 -G n8n -s /bin/sh -D n8n; \
    fi

# Создание директорий и установка прав
RUN mkdir -p /data/.n8n && \
    chown -R n8n:n8n /data && \
    chmod -R 755 /data

# Переключение на пользователя n8n
USER n8n

# Экспорт порта для Render
EXPOSE 10000

# Установка переменной среды для порта
ENV N8N_PORT=10000
ENV N8N_LISTEN_ADDRESS=0.0.0.0

# Healthcheck для мониторинга
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
    CMD curl -f http://localhost:10000/healthz || exit 1

# Команда запуска
CMD ["n8n"]