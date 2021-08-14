HW1 Terraform

# Выполнено ДЗ № 1

- [x] Основное ДЗ

## В процессе сделано:

- Написаны конфигурационные файлы Terraform, описывающие создание одной ВМ в Yandex Cloud и запусуск Ansible
- Написал простой Ansible Playbook, обновляющий пакеты и разворачивающий nginx

## Как запустить проект:

Для всех файлов, которые необходимо изменить существуют примеры с расширением .example

1. Экспортировать ключ сервисного аккаунта Yandex Cloud в файл `hw1/terraform-bot-key.json`

[Документация YC: Создание авторизованных ключей](https://cloud.yandex.ru/docs/iam/operations/authorized-key/create)

Сервисный аккаунт должен иметь следующие роли в каталоге:

- `vpc.admin`
- `storage.admin`
- `compute.admin`

2. Создать S3 Bucket и настройте Terraform backend

[Документация YC: Создание бакета](https://cloud.yandex.ru/docs/storage/operations/buckets/create)

[Документация YC: Создание статитеческих ключей доступа](https://cloud.yandex.ru/docs/iam/operations/sa/create-access-key)

3. Заполнить переменные в terraform.tfvars

4. Запустить Terraform

```
terraform apply --auto-approve
```

## Как проверить работоспособность:

На 80 порту хоста с запущенным docker будет работать nignx.
Публичный ip адрес будет показан в конце вывода команды terraform apply.
