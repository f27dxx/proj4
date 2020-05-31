Implementation matters:
The app is using Vue as frontend framework and PHP(PDO) as a API endpoint.
database using mySQL.
backend database and server hosted on heroku, using JawsDB add-on provided by Heroku for database interaction.
Imported data from local DB to hosted DB using SQLworkbench.
Frontend vue hosted on Netlify.
For API endpoint, it allows referer only from 'trazzie.com', refuse to work with connection other than my domain.
For admin route, it check if the IP from the client matches the environment variable I set, if not, it redirect to page 404 not found to provide security.

# proj3

## Project setup

```
npm install
```

### Compiles and hot-reloads for development

```
npm run serve
```

### Compiles and minifies for production

```
npm run build
```

### Lints and fixes files

```
npm run lint
```

### Customize configuration

See [Configuration Reference](https://cli.vuejs.org/config/).
