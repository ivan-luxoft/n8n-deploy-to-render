# N8N + PostgreSQL на Render.com

Этот репозиторий содержит конфигурацию для быстрого развертывания n8n с базой данных PostgreSQL на Render.com.

## 🚀 Быстрое развертывание

[![Deploy to Render](https://render.com/images/deploy-to-render-button.svg)](https://render.com/deploy?repo=https%3A%2F%2Fgithub.com%2Fivan-luxoft%2Fn8n-deploy-to-render)

## 📁 Структура файлов

```
├── render.yaml      # Конфигурация инфраструктуры
├── Dockerfile       # Docker образ для n8n
└── README.md        # Данная инструкция
```

## 🛠 Что будет развернуто

### Сервисы:
- **n8n-postgres** - PostgreSQL база данных (plan: free)
- **n8n-service** - N8N веб-приложение (plan: free)

### Переменные окружения:
- Автоматическое подключение к PostgreSQL
- Генерация ключей шифрования
- Настройка webhook URL
- Production-ready конфигурация

## 📋 Шаги развертывания

### 1. Создание репозитория
```bash
git clone <your-repo-url>
cd n8n-render
```

### 2. Развертывание через Render Dashboard
1. Перейдите в [Render Dashboard](https://dashboard.render.com)
2. Нажмите "New" → "Blueprint"
3. Подключите ваш GitHub репозиторий
4. Render автоматически обнаружит `render.yaml`
5. Нажмите "Apply"

### 3. Развертывание через Git
```bash
git add .
git commit -m "Initial n8n setup"
git push origin main
```

## 🔧 Настройка после развертывания

### Получение URL сервиса
После развертывания ваш n8n будет доступен по адресу:
```
https://n8n-service-XXXX.onrender.com
```

### Первоначальная настройка
1. Откройте URL в браузере
2. Создайте учетную запись администратора
3. Настройте первый workflow

### Дополнительные настройки безопасности

Если нужна базовая аутентификация, раскомментируйте в `render.yaml`:
```yaml
- key: N8N_BASIC_AUTH_ACTIVE
  value: true
- key: N8N_BASIC_AUTH_USER
  value: admin
- key: N8N_BASIC_AUTH_PASSWORD
  sync: false  # Установите через UI
```

Затем в Render Dashboard:
1. Перейдите в Environment
2. Добавьте переменную `N8N_BASIC_AUTH_PASSWORD`
3. Установите безопасный пароль

## 📊 Мониторинг и логи

### Просмотр логов
```bash
# В Render Dashboard перейдите в Logs вашего сервиса
```

### Health Check
N8N автоматически настроен с health check на `/healthz`

### Метрики
Metrics включены и доступны для мониторинга производительности

## 🔄 Масштабирование

### Увеличение ресурсов
Измените `plan` в `render.yaml`:
```yaml
plan: starter  # или standard, pro
```

### Добавление воркера
Раскомментируйте секцию worker в `render.yaml` для обработки тяжелых задач отдельно.

## 🐛 Устранение неисправностей

### Проблема с подключением к БД
1. Проверьте статус PostgreSQL сервиса
2. Убедитесь, что переменные БД корректно подключены
3. Проверьте логи n8n сервиса

### Медленная работа
1. Увеличьте план сервиса
2. Добавьте отдельный воркер
3. Оптимизируйте workflows

### Ошибки webhook
1. Проверьте переменную `WEBHOOK_URL`
2. Убедитесь, что URL доступен извне
3. Проверьте настройки firewall

## 📝 Переменные окружения

| Переменная | Описание | Источник |
|------------|----------|----------|
| `DB_TYPE` | Тип БД | `postgresdb` |
| `DB_POSTGRESDB_HOST` | Хост БД | Auto from database |
| `N8N_HOST` | Хост n8n | Auto from service |
| `N8N_ENCRYPTION_KEY` | Ключ шифрования | Auto generated |
| `WEBHOOK_URL` | URL для webhooks | Auto from service |

## 🔒 Безопасность

- Все секретные ключи генерируются автоматически
- База данных изолирована в приватной сети
- HTTPS включен по умолчанию
- Логи не содержат чувствительной информации

## 💰 Стоимость

При использовании бесплатных планов:
- PostgreSQL: $0/месяц
- N8N сервис: $0/месяц
- Ограничения: 750 часов/месяц, 512MB RAM

## 🔗 Полезные ссылки

- [N8N Documentation](https://docs.n8n.io/)
- [Render Documentation](https://render.com/docs)
- [N8N Community](https://community.n8n.io/)

## 📞 Поддержка

При возникновении проблем:
1. Проверьте логи в Render Dashboard
2. Обратитесь к документации N8N
3. Создайте issue в этом репозитории
