# BUSCADOR - ML CHALLENGE

## Arquitectura

Si bien usar MVC hubiese sido suficiente por la extensión del proyecto, en este caso decidí utilizar MVVM para poder demostrar como organizaría un proyecto de mayor embergadura.

La ventaja de MVVM es en separar la vista del modelo, esto hace  que cuando el modelo tenga que cambiar no esté sujeto a la vista, y visceversa.
Para la comunicación entre módulos utilizo protocolos. La vista se comunicará con la lógica del negocio, y esta última con la vista. 
En cuanto a testing del viewmodel, es posible hacerlo sin estar en contacto con la vista. De esta manera resulta mucho mas limpio y sencillo. 

## Vista Reusable o Custom View

El motivo por el cual uso vistas reusables tiene que ver con la separación y código limpio. Por ejemplo, si tengo que presentar una vista con un TableView no necesito volver a repetir código que tenga que ver con el seteo del mismo, esto es posible gracias a las propiedades de Herencia y el uso de Generics en Swift.
Tambien es importante destacar que se obtiene una abstracción de la nueva implementación, teniendo toda la funcionalidad dentro del objeto instanciado.
Todo esto se encuentra implementado en las siguientes clases:

### XibView
### GenericTableView
### GenericTableViewCell
### ProductListView



