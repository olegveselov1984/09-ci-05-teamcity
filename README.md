# Домашнее задание к занятию 11 «Teamcity»

## Подготовка к выполнению

1. В Yandex Cloud создайте новый инстанс (4CPU4RAM) на основе образа `jetbrains/teamcity-server`.

<img width="1609" height="60" alt="image" src="https://github.com/user-attachments/assets/55c316c9-ab52-49fe-8a05-228f2cf95ebd" />

2. Дождитесь запуска teamcity, выполните первоначальную настройку.

<img width="1400" height="788" alt="image" src="https://github.com/user-attachments/assets/688749c2-295b-49f2-8403-adf4c926eba3" />

3. Создайте ещё один инстанс (2CPU4RAM) на основе образа `jetbrains/teamcity-agent`. Пропишите к нему переменную окружения `SERVER_URL: "http://<teamcity_url>:8111"`.

<img width="1594" height="54" alt="image" src="https://github.com/user-attachments/assets/992474fe-f8c1-4e41-bef6-866862fc7312" />

4. Авторизуйте агент.

<img width="952" height="380" alt="image" src="https://github.com/user-attachments/assets/41804a23-4224-4255-b163-b4c83dc2653a" />


5. Сделайте fork [репозитория](https://github.com/aragastmatb/example-teamcity).

<img width="1076" height="599" alt="image" src="https://github.com/user-attachments/assets/d6612e83-b411-4978-a70b-13cd40ffd056" />

6. Создайте VM (2CPU4RAM) и запустите [playbook](./infrastructure).

<img width="1307" height="424" alt="image" src="https://github.com/user-attachments/assets/002eb887-4f83-48b3-9898-4be4746ac963" />






## Основная часть

1. Создайте новый проект в teamcity на основе fork.
2. Сделайте autodetect конфигурации.
3. Сохраните необходимые шаги, запустите первую сборку master.

<img width="1153" height="688" alt="image" src="https://github.com/user-attachments/assets/d44936e7-a491-4b32-aa00-fb6ffaa1d33a" />

4. Поменяйте условия сборки: если сборка по ветке `master`, то должен происходит `mvn clean deploy`, иначе `mvn clean test`.

<img width="1375" height="567" alt="image" src="https://github.com/user-attachments/assets/da7386e7-8ed9-4a79-ac2c-ae97aea95d07" />

5. Для deploy будет необходимо загрузить [settings.xml](./teamcity/settings.xml) в набор конфигураций maven у teamcity, предварительно записав туда креды для подключения к nexus.

<img width="942" height="417" alt="image" src="https://github.com/user-attachments/assets/d7306160-6574-4f8a-b13c-fd6f5f63f0c8" />

6. В pom.xml необходимо поменять ссылки на репозиторий и nexus.
7. Запустите сборку по master, убедитесь, что всё прошло успешно и артефакт появился в nexus.
8. Мигрируйте `build configuration` в репозиторий.
9. Создайте отдельную ветку `feature/add_reply` в репозитории.
10. Напишите новый метод для класса Welcomer: метод должен возвращать произвольную реплику, содержащую слово `hunter`.
11. Дополните тест для нового метода на поиск слова `hunter` в новой реплике.
12. Сделайте push всех изменений в новую ветку репозитория.
13. Убедитесь, что сборка самостоятельно запустилась, тесты прошли успешно.
14. Внесите изменения из произвольной ветки `feature/add_reply` в `master` через `Merge`.
15. Убедитесь, что нет собранного артефакта в сборке по ветке `master`.
16. Настройте конфигурацию так, чтобы она собирала `.jar` в артефакты сборки.
17. Проведите повторную сборку мастера, убедитесь, что сбора прошла успешно и артефакты собраны.
18. Проверьте, что конфигурация в репозитории содержит все настройки конфигурации из teamcity.
19. В ответе пришлите ссылку на репозиторий.

---

### Как оформить решение задания

Выполненное домашнее задание пришлите в виде ссылки на .md-файл в вашем репозитории.

---
