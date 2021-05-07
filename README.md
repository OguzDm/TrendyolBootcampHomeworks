# TrendyolBootcampHomeworks

Soru: Frame vs Bounds açıklayınız?
Cevap: Frame = View’in parent’ının içerisindeki koordinat sistemine göre lokasyonunu ve boyutlarıdır. Bound ise View'ın kendi içerisindeki koordinat sistemine göre lokasyonunu ve boyutlarıdır.
bunun önemi şudur eğer bir parentın içerisne view yerleştiriyorsanız frame sizin için önemlidir. 


![1*Nid_PMoniLYLNYHmhHJEjw](https://user-images.githubusercontent.com/33404285/116796231-93dd8b00-aae3-11eb-8ebf-7aded7235575.png)


Soru: UIViewController yaşam döngüsünü araştırıp her bir methodu kendi cümlelerinizle özetleyiniz 
Cevap: ViewWillAppear -> Viewınız gözükmeden önce çalışır ve bu işlem Viewınız gözükmeden önce her seferinde tekrarlanır.
ViewDidLoad-> Viewınızın tamamen yüklendiği 1 kere çalıştırılan bir durumdur.
ViewDidAppear -> Viewınız gözüktükten hemen sonra çalışır. 
ViewWillDissappear -> Viewınız ekrandan kaybolmadan hemden önce çalışır.
ViewDidDissappear -> Viewınız ekrandan kaybolduktan sonra çalışır.


![resim](https://user-images.githubusercontent.com/33404285/116796417-e9666780-aae4-11eb-93c1-105a73c47bef.png)

Soru: Static keyword neden kullanırız. Örnek bir kullanım yapınız

Cevap: Static properties tanımlandıkları yerde shared bir propertie oluştururlar yani bir objeye değil bir classa ya da örnek olarak bir structa ait olurlar.

Örnek: her iOS developerın kullandığı macin modeli ya da macin içerisindeki işlemcisinin modeli farklıdır ancak her ios developerın kullandığı os MacOS tir
MacOS yaratılan instancea değil structa aittir.

![Ekran Resmi 2021-05-02 01 41 51](https://user-images.githubusercontent.com/33404285/116796738-9f32b580-aae7-11eb-9a2a-0299818974dc.png)

Soru: LoadView'ı araştırınız.

Cevap: LoadView controllerın yönettiği bir view yaratmak için kullanılır. Storyboard kullanmadan viewımızı sadece programmaticaly yaratıyorsak kullanımı öneriliyor aksi takdirde önerilmiyor.
