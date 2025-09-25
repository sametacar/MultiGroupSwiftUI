Readme: Odev-11 

Kullanılan Api:
Rick and Morty Rest Api (https://rickandmortyapi.com/documentation)

Proje Structure'ı;
MVVM yapısı kullanıldı.
View ve viewModel'ler UI dizininde tutulmakta. 
Açılış anında MainTab yüklenmekte.
MainTab'ın Karakterler(ContentView) ve Favoriler(FavoritesView) adında iki tabı bulunmakta. 
Listede karaterler çekilip lazyloading ile gösterilmekte. liste elemanları CharacterRowViewde işlenmekte. 
Favoriye eklenen characterler tum item object'i ile beraber UserDefault'sa kaydedilmekte.  
Network için BuddiesNetwork kütüphanesi kuruldu.
