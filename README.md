# 🎬 Movies VIPER App

Aplicación iOS desarrollada en **Swift** utilizando arquitectura **VIPER** y UIKit. Consume la API de [The Movie Database (TMDB)](https://www.themoviedb.org/) para mostrar películas próximas a estrenarse. La app incluye autenticación local y navegación entre módulos con estructura desacoplada.

---

## 🚀 Características

- Login local con credenciales predefinidas (usuario: `Admin`, clave: `Password*123`)
- Consumo de películas con scroll infinito usando la API de TMDB
- Navegación entre módulos usando VIPER
- Imágenes optimizadas con **Kingfisher** (cache y carga asíncrona)
- Diseño visual tipo tarjeta 
- Fondo oscuro elegante con `navigationBar` personalizado
- Modularizado por componente (`Login`, `MoviesList`, `MovieDetail`)

---

## 📦 Dependencias

- [`Kingfisher`](https://github.com/onevcat/Kingfisher): Carga de imágenes remota con cache y placeholders

---

## ⚙️ Configuración

1. Clona el repositorio
2. Abre el proyecto `.xcodeproj` en Xcode
3. Asegúrate de tener configurado un archivo `Environment.plist` con:

```xml
<key>API_BASE_URL</key>
<string>https://api.themoviedb.org/3</string>
<key>API_KEY</key>
<string>AQUÍ_TU_API_KEY</string>