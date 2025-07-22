'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {".git/COMMIT_EDITMSG": "80d763d2408e27624ec67047c8c8bb12",
".git/config": "96b8e617dc0cf3fbb2abe16635052732",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/HEAD": "5ab7a4355e4c959b0c5c008f202f51ec",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/fsmonitor-watchman.sample": "a0b2633a2c8e97501610bd3f73da66fc",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-commit.sample": "5029bfab85b1c39281aa9697379ea444",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/push-to-checkout.sample": "c7ab00c7784efeadad3ae9b228d4b4db",
".git/hooks/sendemail-validate.sample": "4d67df3a8d5c98cb8565c07e42be0b04",
".git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
".git/index": "88a0a1451910adb70dd7e2b560fa26aa",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "7fe9001ef23de837ca181d7368f4e53a",
".git/logs/refs/heads/gh-pages": "7fe9001ef23de837ca181d7368f4e53a",
".git/objects/03/2fe904174b32b7135766696dd37e9a95c1b4fd": "80ba3eb567ab1b2327a13096a62dd17e",
".git/objects/03/9512a78a52425adea040951db4989368f21771": "82d163a012041d4bcdb9a38f72e04886",
".git/objects/05/65e00f52d3e0239d07288aabe7470180b24e01": "0e8932b2ef9ee8977d675ea4495df1bf",
".git/objects/06/ef7d44a4dbe568e41155c12c302b366efb4e54": "6ce5b03ac959f1f89f4e215bead4fba9",
".git/objects/08/01cb6d887d83b32969103df84718a660ba7c12": "6d9c3fc122a8566f895cf84eee0748a2",
".git/objects/11/6b3252a9b3399b4f20e34758ab6f5b9764c967": "db6cc5b76c2e7db665e24804101bf4cd",
".git/objects/14/fdc8f6e6f09c64f9cee232d5ea2c431a68497d": "aa08eda05410f77dfb75ae5eae4bc129",
".git/objects/16/5c489b8dfdca5944bac43adfe9775ce08a429a": "06ac0d9de8f3ec6dfcfe75b9ed15da88",
".git/objects/1c/18a344684640cd2278ed862ef4069e17434da7": "9d0e01118e6a4f524b8135d30155ee05",
".git/objects/1c/dfa514bd423d43177dd41974c74db306f6d0f6": "964137f0fd102a5d2471b43bf50df6f3",
".git/objects/1c/f8fb59175164df32095a8062fcc487fff0eb1b": "083441a7d1431b5b00ffa7cea428751b",
".git/objects/20/7dfd364618c624a32d22fb40a14d0f7e61f013": "38efde86f1818f27fdec223d0fc93bd6",
".git/objects/22/6c18063214a0a93c050e6d7aff9f37b8e653e2": "970bf5ff74e90a466c19341baa8591be",
".git/objects/23/05913bdf6e4ef3acbc82f52cec1ee59a988530": "22f663e5bf8961034a41148b74e7148b",
".git/objects/26/bb1992786f5286bf30c327676f41c3b47d4a11": "241f5fd6d78b34d695ee95179f7cbd54",
".git/objects/28/b0f0410c986b67d6bbf8de00ed2912fddece6a": "4d2a7d42f90e616e1105acf518a61d7f",
".git/objects/2a/266618060c2ed8d991e6937d66231e7a88d154": "266d1257b56c185f34dc08eb3650c355",
".git/objects/2d/d60d50b6d6ad578c685542feb8c6fe6adb0aba": "dcd1a0257a45fc4c6693116f4a4fe750",
".git/objects/2d/edcbe059ec4a299c52128cc338ac4d378e5b78": "eb836a133f6f7c7883dc240feecbfd35",
".git/objects/2e/6cdc7797cb06c86a9bb3de57669925739458a1": "44253cdd8cc48257e91804c23d6c5860",
".git/objects/2e/cf840ef4a67befd1a9a926c705e1c1b8652b5b": "18a1a1ff06eae81f81a3621213ad1cf1",
".git/objects/31/36c475120f8aeea5966c000b68939e57463a9e": "f49c5ebc0f8e082651a918bba8ccf189",
".git/objects/32/d02da8081b27e5ee74d6b0f4d6be475c690e00": "0bd4de7f93164da36cce587674df3cd3",
".git/objects/33/31d9290f04df89cea3fb794306a371fcca1cd9": "e54527b2478950463abbc6b22442144e",
".git/objects/34/c7f080767b3b25fed54e966a624fc8b66c14d6": "c94ae3b85292bdb828dad2087adfce5f",
".git/objects/35/96d08a5b8c249a9ff1eb36682aee2a23e61bac": "e931dda039902c600d4ba7d954ff090f",
".git/objects/38/2e569a09587cba97224e504b3cdcad07bd0649": "c97ad8af98f97027b77db091c4ae276e",
".git/objects/3c/96bdbb0fdc2ad479a9f45ad30848fd1920bfd0": "0bfc84d9bc11d4768f83d7e92cd34317",
".git/objects/40/1184f2840fcfb39ffde5f2f82fe5957c37d6fa": "1ea653b99fd29cd15fcc068857a1dbb2",
".git/objects/40/8d8fa5e581a5bb4297cccb84e9b6a279d4461a": "d80fd5228b957b385f66de1d2a208565",
".git/objects/46/4ab5882a2234c39b1a4dbad5feba0954478155": "2e52a767dc04391de7b4d0beb32e7fc4",
".git/objects/49/79eaf8fb0b5392bcc7fbec3bf5ce065364c68b": "de190b564a7f3086927a447db9a671a7",
".git/objects/4b/a27049fdd7732b45f11e50a436c44e661a1b20": "5cefe48d4cd3d6015b4ec23c4b0a33c9",
".git/objects/4c/dcd4c825ec22c0bc0c5930ecc9b9845c47cda4": "018dd4b216dd648508bce35a80de1861",
".git/objects/4f/02e9875cb698379e68a23ba5d25625e0e2e4bc": "254bc336602c9480c293f5f1c64bb4c7",
".git/objects/53/065fa481802eb97c351a1c9b5dabe7e6b18aab": "7b5be1c21b790f9bd10a9339f724203b",
".git/objects/57/7946daf6467a3f0a883583abfb8f1e57c86b54": "846aff8094feabe0db132052fd10f62a",
".git/objects/58/7b269b69ab09d5074550ce1c99dd01a0c5c5c4": "70a51a89c75545536332f3d2b80246da",
".git/objects/5a/76a85aed7f55d216d7636aec9e0e5460fc86ea": "c8a6256827ec67e4efd5d34dff11895d",
".git/objects/5b/095be3cda641cbe52827e03b7ae288cc2f8370": "0a37a56f69fa91c9d619072fb92e29e0",
".git/objects/5e/1bca83c66363f93e3a22c607398a19cf7d6649": "2bb3f956609e72354f2cc5480ae07aa1",
".git/objects/5f/4c4d4a0dc13e15a53f911d1a0c2db565612b1a": "c741bc9aa4d87a5d27eaa49f1a9fbe46",
".git/objects/5f/bf1f5ee49ba64ffa8e24e19c0231e22add1631": "f19d414bb2afb15ab9eb762fd11311d6",
".git/objects/61/9195c78c5504f9a677105932a8be7e8e6a3766": "5d9b5e38d44fd8f96822da46f6c98f2d",
".git/objects/61/ac46505ba420d39d8f3934de74347091b4182a": "e8704a7098f31a2b713f026f938c7ffd",
".git/objects/64/5116c20530a7bd227658a3c51e004a3f0aefab": "f10b5403684ce7848d8165b3d1d5bbbe",
".git/objects/6a/fbac857f17d8bb8a9ae1df60366d29094490ef": "1f36c9167d69f534006e769a3b614be0",
".git/objects/78/04bcda2147eb9e65ecf96b9b2ba60ee94e5b3e": "88e3ec81503b645880675ffb068710eb",
".git/objects/7b/ca45a283784c34c8e2ee723f854b7f5f66c8fb": "a1243b2bb2a68a6e325efe59456bdab0",
".git/objects/7d/32274d22deaea393997924fbda3f2f78ffbea4": "be5c58b8f88b44a6d2138bd19c5cbc3c",
".git/objects/7e/5809e2da96d2f8c733a0b42072804cc1418c11": "7cedc3b02368ce7b8ed080b03eb7c3dc",
".git/objects/82/652f4f3ad899a9801a26ef2da620bcd272bde9": "519bf6a42878c45c665939a8dc5f18df",
".git/objects/84/fc6ad94b4d1d38a46586f51b6e07518392525f": "db90a911ffd4a6423792d81b354cbf33",
".git/objects/89/2ede9a9c275dc5295dfb0d7ae308dec8be5ab9": "2fa6336f3e0c3d09f7601fa487fe5117",
".git/objects/8a/51a9b155d31c44b148d7e287fc2872e0cafd42": "9f785032380d7569e69b3d17172f64e8",
".git/objects/8b/58704ebb8f917dfbc22cb64757b83f8edb27c9": "412edc618b8d27301ca7c95c6cd29065",
".git/objects/91/4a40ccb508c126fa995820d01ea15c69bb95f7": "8963a99a625c47f6cd41ba314ebd2488",
".git/objects/92/cc53d17fdd901597df321138e908d81c8eb2ee": "2fac0b9b0b5b3a6d19561b38fbe14ceb",
".git/objects/93/be7fd9b9dcdd8564dafd7040a0c8c8f68d4080": "b27ff257c793a735fc818ff37f392ff9",
".git/objects/93/c4eb410791505c2068fc7257b1346d8ac77dbf": "d3f8f0019d379c9688d8820e0eb30ada",
".git/objects/9a/a8a763cd5532d28e6b495427289151bc6e07be": "c457ed280934873e2383b659331392c2",
".git/objects/9a/d9ced5216fe568e069a6573a7f010d4e24d582": "1a9b21ad7ddd427bb41554d0838584ea",
".git/objects/9b/4c65262a775826130fab19002536219ec6e4e5": "bdee4e932f42fc37812f2a56d3b6f1cf",
".git/objects/9b/9db76d907c22c3dcefd5eb4e430fff004cd0c3": "5ecd6809e1d365233e3474d974d45466",
".git/objects/9d/14737f3760d005f3fad0c0e619acab465a1322": "aaf851e4cebf214ed34e0202a0943851",
".git/objects/a0/3560171f00eb231456baf0dd0ae9f96467ca1c": "80698d5b56bb332f70af7bd190d99db2",
".git/objects/a5/de584f4d25ef8aace1c5a0c190c3b31639895b": "9fbbb0db1824af504c56e5d959e1cdff",
".git/objects/a8/8c9340e408fca6e68e2d6cd8363dccc2bd8642": "11e9d76ebfeb0c92c8dff256819c0796",
".git/objects/a9/91f51138ffe059d588003dc7936aff059a0428": "b73a35563fa129bd884d8b5c53ee9231",
".git/objects/ab/197250fc044d20a053cea4782a0f7d6b325934": "554a533756084a2175790375262a41dd",
".git/objects/ad/2f90b78480aeb6608226d9db4ecbd3ec06aaeb": "4add97a99941aa0e9eed0f2173416ade",
".git/objects/af/670e0d05be2a3b5185d8ea9964860672fbabab": "0ea749622423651fdb83f0e316596d18",
".git/objects/b3/d975424ccf179a8687894b55006b4f8ea5ca16": "23867dfa00a0d6aaf7ad06c186edf30c",
".git/objects/b7/cd98e84fcf0796764eedeb5290e2626eb90984": "dd5a721f9c1f24d1fa9e97f7f750e1dd",
".git/objects/bc/7d993f94baf32ca11e5f5dc5412aac12a668a9": "d782f8a82d795ae96da7df117f4c51bd",
".git/objects/c3/f564700bb5c70226cf304ad8b84f2db6e95dc5": "b2a13d939cbc00a22b24bf93676925fc",
".git/objects/c4/06d401f57ca3884ca83ada6fd834442a6b7d09": "adc40d2d9f34c04552e65a14ac821718",
".git/objects/ca/28c42816e1ba98b5202e9a751a7a71c42d96e6": "963cafb9d7043e8a4b08248318128b18",
".git/objects/cc/fab74c1f56c330985060e2247607eaedb3c7d7": "ad5b6117df489509af208438785f208b",
".git/objects/cd/e6fe53e33a2115cfb5ac10b8f03a4782b4a004": "58f66eac1238f4a3142ee5aa81025404",
".git/objects/d1/0d0b572a59b45ce5facfafee2154d2e1f8f616": "213edcd183e21328ffde2c2c5a33b6ca",
".git/objects/d3/b661e220bc225725d6a880679e965220655720": "ef97f666f0db2c46510cd76e92f448e2",
".git/objects/d4/3532a2348cc9c26053ddb5802f0e5d4b8abc05": "3dad9b209346b1723bb2cc68e7e42a44",
".git/objects/d8/5d3bef4f2239ca3cd3869c2f87d19e6cee8027": "d4a7a578cb174d24dc33299c9872dbc0",
".git/objects/d9/3952e90f26e65356f31c60fc394efb26313167": "1401847c6f090e48e83740a00be1c303",
".git/objects/e8/63ff7fc87961bdec55f93be808f271ab6bb81c": "8436cff9986acaf9291b8dd71a313975",
".git/objects/e9/528114276aea2d97c0045c732503df0adbd5a2": "7cc1bac7b3435ad2341c8eb808a7a4b2",
".git/objects/eb/258a90e4f68f62cc4e32b612435930fcaf1cc7": "bc046e4433cf4e65b7d992fd0844b242",
".git/objects/ef/b875788e4094f6091d9caa43e35c77640aaf21": "27e32738aea45acd66b98d36fc9fc9e0",
".git/objects/f2/04823a42f2d890f945f70d88b8e2d921c6ae26": "6b47f314ffc35cf6a1ced3208ecc857d",
".git/objects/f3/709a83aedf1f03d6e04459831b12355a9b9ef1": "538d2edfa707ca92ed0b867d6c3903d1",
".git/objects/f3/79b55b870a036e23330fb93a1279cbdebaf1f4": "9247f76053504a83c4de12789620a999",
".git/objects/f6/cc06a0d471df5df1f35082b09b45fced798d05": "b3ed116bd3c82d600d635270058f4345",
".git/objects/f8/b5a606ba4b8a1ce62f9dbd6e6daa6771f70004": "0ad64f2119d135d2fdc493130be5589e",
".git/objects/fb/2fefecdf6e5c7e315e7fb8061abb3a2053ce48": "87c80031505bcaba6e116007dc238477",
".git/objects/fd/676fdc2a5265a568f5a81e6b8f89e8ae4bf8a4": "6dfb320f7df55319e7475d5e3b2fe405",
".git/refs/heads/gh-pages": "61039c20b8a56386aed7649633762c83",
"assets/AssetManifest.bin": "e2d6dd2a650f46ced6c25ffddb90c28c",
"assets/AssetManifest.bin.json": "f475bf4b51736974dcc221daf5ecf069",
"assets/AssetManifest.json": "1579711168bae62fea45a5e4f9dc77dd",
"assets/assets/app/ic_launcher-android.png": "d51cdc4311f4bc1c6b6ee87692f76d34",
"assets/assets/app/ic_launcher.png": "d51cdc4311f4bc1c6b6ee87692f76d34",
"assets/assets/app/logo_splash.png": "b79da8f54eb22e4597005cc5cd6c16f5",
"assets/assets/app/logo_splash_bottom.png": "71f07039da2bb8c2ac44254e64404c90",
"assets/assets/images/audiotrack_resource.png": "67eeb42d7d735b6fb741ca3f0bf468b5",
"assets/assets/images/banner.png": "19e19e82fad814837064593225237272",
"assets/assets/images/books.svg": "db50ce6285a6a54c877dbbb9aac335ec",
"assets/assets/images/books.ttf": "3ebfaad95ecd8fce223d9770839cdb42",
"assets/assets/images/Brands.png": "9be0c8c24a2c079031765e0a28230236",
"assets/assets/images/button_click.png": "774689dfc0c496cca7fe9d51aef7e970",
"assets/assets/images/button_play.png": "215b5292394f8c73e7fe4130dee77132",
"assets/assets/images/calendar.png": "212c8f8055015e8f1a295033cd48b9d4",
"assets/assets/images/curso.svg": "efcdda161bd082304b976ede543ed38b",
"assets/assets/images/download-finished.png": "171073c7cec146e405e07fecc1371ce3",
"assets/assets/images/download.png": "a90058cee3fe9516cb615bff4bf2402e",
"assets/assets/images/downloading.png": "815423b2d62b3fe6d3e0bce3e79c4d6a",
"assets/assets/images/Ebook.png": "73151264d331cc3bc09e54b35006e80a",
"assets/assets/images/ebook_resource.png": "51fa1795fd48fdf42cc6cf1b7bd45c81",
"assets/assets/images/favoritar.png": "16442453ff7aa67e6026164134beeea4",
"assets/assets/images/favoritarfillicon.png": "a1c30e7babeece72b031b8806423aebf",
"assets/assets/images/game_case.png": "f563b3935ccfc1c7da955e2907d758b2",
"assets/assets/images/game_case_resource.png": "3761d340b51f94f8c7464378d318cf5f",
"assets/assets/images/global-line.png": "f5c81670524c794458fcb7c84f685240",
"assets/assets/images/google.png": "16597b58fb4d4fa8ebcf5a013fc19b0a",
"assets/assets/images/Group.png": "90de03a66ecf270798b652525f7adc58",
"assets/assets/images/haze-line.png": "2ff1073d63760ab9cdd1a7472eff3472",
"assets/assets/images/heart-fill.png": "ebc43627596194c710c9e935838bbea0",
"assets/assets/images/home.svg": "5bea1e70e19cdd34fd9dad9230a31b5c",
"assets/assets/images/Infografico.png": "34da135a807fa930dc60e32c30d5941d",
"assets/assets/images/infographic_resource.png": "5e58a12650cd6d105216f6fb72e209f0",
"assets/assets/images/informacao.png": "300ba1bacd298e61227bcc7dc63e9f6b",
"assets/assets/images/like-fill.png": "768839bbaf87301adb7c219719428df1",
"assets/assets/images/like.png": "e277d939042d7d8d32edde272721e8aa",
"assets/assets/images/logo_biblioteca.png": "4a9d98736a7bc719b70768c6abd53a3c",
"assets/assets/images/media.png": "4bc1dc6d29ad040b664d975ee6e0b0f0",
"assets/assets/images/multimidia_resource.png": "0c64a71c68b9e857968ccdbb9b4e0b8b",
"assets/assets/images/pdf.png": "f994976344e961932376ba0f5e975953",
"assets/assets/images/pdf_resource.png": "a90e7a629055fc936826fcce114ac9f9",
"assets/assets/images/perfil.svg": "315092a7f73a20f8952a56cdf7e867d1",
"assets/assets/images/podcast.png": "ad3405ab26d5c2d4b8aac7fde8c16bfe",
"assets/assets/images/profile.png": "de615d1010040c458ac0d7337298c2ef",
"assets/assets/images/recurso_multimidia.png": "2e0d53416cd73a44bd2096aea37e141c",
"assets/assets/images/search.svg": "b607d6fb149e07a0cd814c854f00439d",
"assets/assets/images/share.png": "9a87b2323004d6fa5bb18708c9424e04",
"assets/assets/images/siren-fill.png": "90de03a66ecf270798b652525f7adc58",
"assets/assets/images/star.png": "1f4bd5819693cc7b8f0b036399002cfd",
"assets/assets/images/starAvaliation.png": "ce6bc778e30316528f211ae7a3279668",
"assets/assets/images/starAvaliationNotFill.png": "47771227ffcd54d192cb0e571be3fc8d",
"assets/assets/images/ver_mais.png": "42920fccd780032d1ab33ca385c8d64d",
"assets/assets/images/video_resource.png": "b70af7969ad6d89dcdbe856ab8dccb3f",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "b684465d24a9f8702099681c74a96bd0",
"assets/NOTICES": "83dd563e231805de8d1d98420d9c7256",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "d7d83bd9ee909f8a9b348f56ca7b68c6",
"assets/packages/wakelock_plus/assets/no_sleep.js": "7748a45cd593f33280669b29c2c8919a",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "86e461cf471c1640fd2b461ece4589df",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/chromium/canvaskit.js": "34beda9f39eb7d992d46125ca868dc61",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206",
"favicon.png": "ea18a9197670143b9b492747100cc788",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"flutter_bootstrap.js": "5a7616ad0a27c5b861767b6a33c85498",
"icons/Icon-192.png": "69cfcdb3dba242fbc82c3d3137035f4e",
"icons/Icon-512.png": "cba2b5fe3598fb46b8db5a85868de4d4",
"icons/Icon-maskable-192.png": "69cfcdb3dba242fbc82c3d3137035f4e",
"icons/Icon-maskable-512.png": "cba2b5fe3598fb46b8db5a85868de4d4",
"index.html": "92ae6a37247cbf0bc76cb8d6f0cdfd3b",
"/": "92ae6a37247cbf0bc76cb8d6f0cdfd3b",
"main.dart.js": "4431dd45fbb90626e49828916851d804",
"manifest.json": "6e6d5630158b1eed3eda8aac53c18526",
"version.json": "2f6f03cec8163feb3f8c5d8ba89f5a32"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
