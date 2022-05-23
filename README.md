# README



=======
### Model tasks

| Colums      | Description |
| ----------- | ----------- |
| name        | string      |
| retail      | string      |
| expiry_date | date        |
| status      | integer     |
| priority    | integer     |
| created_at  | date        |
| update_at   | date        |

### Model users

| Colums                   | Description |
| ------------------------ | ----------- |
| user_name                | string      |
| email                    | string      |
| password                 | string      |
| password_confirmation    | string      |
| user_role                | boolean     |
| created_at               | date        |
| update_at                | date        |

### labels

| Colums      | Description |
| ----------- | ----------- |
| label_name  | string      |
| created_at  | date        |
| update_at   | date        |

### labellings

| Colums      | Description |
| ----------- | ----------- |
| task_id     | foreign_key |
| label_id    | foreign_key |
| created_at  | date        |
| update_at   | date        |

## Procédure de déploiement sur Heroku

### Les commandes suivantes sont à taper sur le terminal

- heroku login
- heroku create TaskManager
- heroku buildpacks:set heroku/ruby
- heroku buildpacks:add --index 1 heroku/nodejs
- git add . 
- git commit -m "message"
- git push heroku master
- heroku run rails db:migrate
- heroku open