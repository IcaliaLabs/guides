# React

## Getting Started
Here are some very useful tutorials on how to get started with React:

- [Intro to React by Facebook](https://facebook.github.io/react/tutorial/tutorial.html)
- [React Training Online](https://reacttraining.com/online)
- [React Blog by Tyler McGinnis](https://tylermcginnis.com/reactjs-tutorial-a-comprehensive-guide-to-building-apps-with-react/)

## Starting a Project
When starting a project with React you have the option to boostrap a new application with [Create React App](https://github.com/facebookincubator/create-react-app) from the Facebook Incubator.

The installation is fairly easy, just go to the terminal and run the following commands:

```
$ npm install -g create-react-app
$ create-react-app <my-project>
$ cd <my-project>/
$ npm start
```
and that's it! Your app is up and running on [http://localhost:3000/](http://localhost:3000/)

## Project Structure
This is the structure Create React App comes with:

```
 my-project/
 	README.md
 	node-modules/
 	package.json
 	.gitignore
 	public/
 		favicon.ico
 		index.html
 	src/
 		App.css
 		App.js
 		App.test.js
 		index.css
 		index.js
 		logo.svg

```

Alternatively, we recommend that you group files together by components, layouts, views and css files like so: 

```
 my-project/
 	README.md
 	node-modules/
 	package.json
 	.gitignore
 	public/
 		favicon.ico
 		index.html
 		logo.svg
 	src/
 		components/
 			calculator/
 				calculator.js
 				calculator.test.js
 		css/
 		index.js
 		layouts/
 			main/
 				main.js
 				main.test.js
 		views/
 			landing/
 				landing.js
 				landing.test.js
```

## Integrating Sass 
To integrate Sass into your React application, you need to go to your terminal and run ```$ npm install create-react-app-sass --save-dev ```.

Finally, all you need to do is replace your ```scripts``` in your ```package.json``` with the following: 

```
"scripts": {
  "start": "react-scripts-with-sass start",
  "build": "react-scripts-with-sass build",
  "test": "react-scripts test --env=jsdom",
  "eject": "react-scripts eject"
}
```

And that's it! Your ```src``` directory will recompile any ```.sccs``` files into a ```.css``` one with the same name and in the same location. You should be able to ```import``` them into your components the same way as before. Finally, add ```*.css``` to your ```.gitignore``` file.


## React Router
To install react router, just run on the terminal:

```
$ npm install --save react-router
```

[This](https://github.com/reactjs/react-router-tutorial) is a good tutorial to get you started with React Router. 

### Routes 
Routes are used for navigating throughout your application, we recommend you add a ```router.js``` file inside the ```src``` directory. This is a basic ```structure``` for this file:

```
import React from 'react';
import { Router, Route, browserHistory } from 'react-router';

// Components
import Calculator from './components/calculator/calculator';

// Layouts
import Main from './layouts/main/main';

// Views
import Landing from './views/landing/landing';

export default (
  <Router history={browserHistory}>
    <Route component={Main}>
      <Route path="/" component={Landing}/>
      <Route path="/calculator" component={Calculator}/>
    </Route>
  </Router>
);
```

### Server-Side Rendering with Express 
To render your router for a production enviornment, run this script on your terminal:

```
# Install dependencies 
$ npm install --save express morgan

# Create server files
$ mkdir server
$ touch server/app.js
$ touch server/index.js
```

Your application's structure should now look like this:

```
 my-project/
 	README.md
 	node-modules/
 	package.json
 	.gitignore
 	public/
 		favicon.ico
 		index.html
 		logo.svg
 	server/
 		app.js
 		index.js
 	src/
 		components/
 			calculator/
 				calculator.js
 				calculator.test.js
 		css/
 		index.js
 		layouts/
 			main/
 				main.js
 				main.test.js
 		router.js
 		views/
 			landing/
 				landing.js
 				landing.test.js
```

Open your ```app.js``` file and write the following code:

```
const express = require('express');
const morgan = require('morgan');
const path = require('path');

const app = express();

// Setup logger
app.use(morgan(':remote-addr - :remote-user [:date[clf]] ":method :url HTTP/:http-version" :status :res[content-length] :response-time ms'));

// Serve static assets
app.use(express.static(path.resolve(__dirname, '..', 'build')));

// Always return the main index.html, so react-router render the route in the client
app.get('*', (req, res) => {
  res.sendFile(path.resolve(__dirname, '..', 'build', 'index.html'));
});

module.exports = app;
```

Now that ```app.js``` is done, it's time to work on ```index.js```. Open your file and write the following code:

```
'use strict';

const app = require('./app');

const PORT = process.env.PORT || 9000;

app.listen(PORT, () => {
  console.log(`App listening on port ${PORT}!`);
});
```
To see if everything is working well, build the app and start the server. 

```
$ npm run build
$ node server
```
If you did it right, everything should be working fine.

## Deploying to Heroku
To deploy your application to a production environment, just follow the [Deploying React with Zero Configuration](https://blog.heroku.com/deploying-react-with-zero-configuration) guide.

Additionally, if you are using react router you may need to create a ```Procfile``` to tell Heroku the command needed to start the server.
It should contain something like this:

```
web: node server
```

## React Examples
To see some really cool examples of what you can do with React, head over to [react.rocks](https://react.rocks).