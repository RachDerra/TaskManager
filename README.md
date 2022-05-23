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