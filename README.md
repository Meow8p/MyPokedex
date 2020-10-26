# MyPokedex
Progetto "playground", creato per imparare Swift e per un primo approccio al modello MVVM

## Dettagli implementativi
Lo scopo di questa app è la visualizzazione di una lista di Pokemon e delle relative caratteristiche principali.  I dati sono recuperati da API pubbliche https://pokeapi.co .

La schermata principale è una tabella che elenca nome e immagine di tutti i Pokemon. L'API utilizzata permette il download di X oggetti alla volta (questa app ne scarica 20 per volta). Ogni volta che durante lo scrolling si arriva all'ultima voce, vengono recuperati i dati successivi e aggiunti alla lista.

Tappando su una cella, si apre una schermata di dettaglio in cui compare l'immagine "principale" del Pokemon, la lista di tutte le immagini disponibili, la lista delle caratteristiche con indicato il valore di base e i tipi del Pokemon.

Ogni parte grafica è costruita via codice, non ho usato storyboard o xib. Lo scopo di questo esperimento non era creare un'app con una grafica "fancy", quindi mi sono limitata ad usare gli strumenti base dell'SDK.

### Pattern MVVM
#### Model
Questa app deve mostrare dati che si possono riassumere in una classe unica: quella che rappresenta un Pokemon. Questa classe è una sotto-classe di quella fornita dalla libreria esterna utilizzata, che già contiene tutto ciò che è necessario. Ho soltanto creato una struct che contiene una lista di Pokemon e alcune informazioni utili durante il processo di costruzione della base dati.

#### ViewModel
Ho creato alcuni view model diversi che utilizzano il model concentrandosi su aspetti diversi.

`PokemonsViewModel` è quello utilizzato per comporre la lista nella schermata principale. Si occupa, quindi, di rendere disponibile alla view la lista di Pokemon, recuperandoli dalle apposite API. Il download è composto dalla chiamata di due API: una per recuperare la lista composta da nome + URL del Pokemon e il download dei dati di ogni singolo Pokemon presente nella lista del punto precedente. Ogni volta che i dati di un singolo Pokemon vengono scaricati e decodificati, vengono aggiunti alla lista utilizzata dalla view.

`PokemonImagesViewModel` è un model "di comodo" utilizzato da entrambe le view e dalle loro celle. Serve per scaricare un'immagine da un URL fornito e rendererla disponibile alla view chiamante.

`PokemonsDetailViewModel` è quello utilizzato per estrarre i dati necessari alla schermata di dettaglio da un singolo Pokemon.

`PokemonTableViewDataSource` contiene il TableViewDataSourceDelegate della tabella principale. Si occupa di accedere ai dati attraverso `PokemonsViewModel` alla tableView, implementando i metodi del delegato.

`PokemonDetailViewDataSource` contiene il TableViewDataSourceDelegate della tabella di dettaglio di un singolo Pokemon. Si occupa di accedere ai dati attraverso `PokemonsDetailViewModel` alla tableView, implementando i metodi del delegato.


#### View
Le due view sono quelle legate alle schermate di cui è composta l'app.

`ListViewController` è la view della schermata principale, in cui compare la lista dei pokemon con la rispettiva immagine.

`DetailViewController` è la view della schermata di dettaglio, in cui compaiono i dati del Pokemon selezionato nella schermata precedente.

## Credits
### Materiale grafico
L'unica immagine che ho utilizzato, al di fuori di quelle scaricabili attraverso le API, è stata recuperata da un repository di icone free. Si tratta, in particolare, dell'icona che utilizzo come placeholder finché l'immagine del Pokemon non è stata scaricata.
In particolare, mi riferisco a questa icona
https://icon-library.com/icon/missing-picture-icon-7.html

### Librerie esterne
Ho scelto di utilizzare la libreria indicata direttamente sul sito delle API per facilitarmi il compito di recupero e parsificazione dei dati ottenuti dalle singole chiamate.
In particolare la libreria è la seguente: https://github.com/kinkofer/PokemonAPI
Per includerla, ho utilizzato il sistema Swift PM, banalmente perché è integrato in Xcode e mi è sembrato più comodo. 
Tipicamente, cerco di limitare al massimo le librerie esterne utilizzate, per cercare di mantenere il più alto livello di controllo sul codice che ne risulta. Secondo la mia esperienza, avere un maggior controllo aiuta in caso di bug e/o di comportamenti inaspettati o in caso di necessità di personalizzazione.

### Tutorials
Per impostare il pattern MVVM, ho seguito questo tutorial
https://medium.com/flawless-app-stories/mvvm-in-ios-swift-aa1448a66fb4

## TODO
### Generali
  * Localizzazione delle stringhe mostrate (le API per alcune cose, possono fornire le traduzioni per le principali lingue)
  * Modificare la attuale cache usata per il download delle immagini, in modo da poterla scrivere/rileggere da disco (al momento è un oggetto NSCache creato al volo)
  * Aggiungere una cache anche per le chiamate alle API, magari anche questa da rendere permanente su disco
  
### Schermata principale
  * Filtri sulla lista dei pokemon
  * Ricerca per nome/caratteristica/tipo
  * Risoluzione del problema relativo al riutilizzo delle celle: a volte, quando ci sono tanti download e tante celle riutilizzate contemporaneamente (in pratica si scrolla velocemente avanti di più paginate possibile), l'immagine scaricata per la schermata precedente viene comunque visualizzata per poi essere rimpiazzata dall'immagine corretta
  
### Schermata di dettaglio
  * Soluzione più gradevole graficamente per mostrare la lista delle immagini (al momento sto usando le celle standard, magari quella sezione della tabella può essere convertita in una collection o qualcosa di più elaborato)
  
