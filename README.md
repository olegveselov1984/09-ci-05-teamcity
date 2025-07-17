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

<img width="1284" height="617" alt="image" src="https://github.com/user-attachments/assets/ef86f4ec-7304-4976-9632-c8d7049eb11b" />

7. Запустите сборку по master, убедитесь, что всё прошло успешно и артефакт появился в nexus.

<img width="626" height="376" alt="image" src="https://github.com/user-attachments/assets/2a6d40ab-d771-498d-a67f-d29bcf4ec905" />


8. Мигрируйте `build configuration` в репозиторий.

<img width="1534" height="867" alt="image" src="https://github.com/user-attachments/assets/d0663163-8dbf-46aa-8762-e2a4ee93fa4f" />


9. Создайте отдельную ветку `feature/add_reply` в репозитории.

<img width="1046" height="468" alt="image" src="https://github.com/user-attachments/assets/cb300d98-8753-4409-94fa-8b81edc1d97b" />

10. Напишите новый метод для класса Welcomer: метод должен возвращать произвольную реплику, содержащую слово `hunter`.

<img width="1282" height="566" alt="image" src="https://github.com/user-attachments/assets/90dd7de9-4f9a-4f27-bf23-b2896fa97f12" />

11. Дополните тест для нового метода на поиск слова `hunter` в новой реплике.

<img width="1146" height="796" alt="image" src="https://github.com/user-attachments/assets/b0facea2-a62b-42e7-8674-e85fbba04e66" />

12. Сделайте push всех изменений в новую ветку репозитория.



13. Убедитесь, что сборка самостоятельно запустилась, тесты прошли успешно.

<img width="1915" height="513" alt="image" src="https://github.com/user-attachments/assets/cfb50c5a-538f-4746-942b-9c0a84a1c4cf" />

14. Внесите изменения из произвольной ветки `feature/add_reply` в `master` через `Merge`.

<img width="1233" height="250" alt="image" src="https://github.com/user-attachments/assets/aa0fb872-147c-4a53-a14c-191dca4a9646" />

15. Убедитесь, что нет собранного артефакта в сборке по ветке `master`.

Нету.
<img width="1306" height="264" alt="image" src="https://github.com/user-attachments/assets/d708e853-006d-4ca4-b24d-32b11653b4f3" />


16. Настройте конфигурацию так, чтобы она собирала `.jar` в артефакты сборки.

Изменить версию:
<img width="1186" height="469" alt="image" src="https://github.com/user-attachments/assets/26e1618d-39c1-4e76-b0c8-e2888810466b" />


17. Проведите повторную сборку мастера, убедитесь, что сбора прошла успешно и артефакты собраны.

<img width="1492" height="846" alt="image" src="https://github.com/user-attachments/assets/253c639f-d6f6-4731-8e13-157148b7d7c0" />

<img width="1209" height="692" alt="image" src="https://github.com/user-attachments/assets/5868c30a-8423-409b-be8a-24e24baf53c0" />

18. Проверьте, что конфигурация в репозитории содержит все настройки конфигурации из teamcity.

версия поменялась 0.0.2

<img width="871" height="477" alt="image" src="https://github.com/user-attachments/assets/e177f077-f3c8-4d54-8406-f80230fa061d" />

В Nexus новая версия появилась
<img width="623" height="419" alt="image" src="https://github.com/user-attachments/assets/7e8f95e9-e68c-4619-8f1d-e0993eb57504" />


**

19. В ответе пришлите ссылку на репозиторий.

https://github.com/olegveselov1984/example-teamcity

https://github.com/olegveselov1984/09-ci-05-teamcity/tree/HW01/example-teamcity

PS ВМ Все ВМ создаются через terraform. ПО устанавливается через ansible. Для nexus используется centos-stream-9-oslogin

---

### Как оформить решение задания

Выполненное домашнее задание пришлите в виде ссылки на .md-файл в вашем репозитории.

---
