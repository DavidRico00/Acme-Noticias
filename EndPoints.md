Accesos:    ALL     -> todos
            adm     -> Administrador
            red     -> Redactor
            lec     -> Lector

| EndPoint                 | Descripcion                  | Metod | Permit |
| ------------------------ | ---------------------------- | ----- | ------ |
| /articulos               | lista todos los articulos    | GET   | ALL    |
| ADMINISTRADOR            | -                            | -     | -      |
| /admin                   | pagina principal del admin   | GET   | adm    |
| /admin/dasboard          | muestra el dashboard         | GET   | adm    |
| /admin/gestionCategorias | muestra todas las categorias | GET   | adm    |
| /admin/gestionRedactores | muestra todos los redactores | GET   | adm    |