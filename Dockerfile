FROM cypress/included:4.1.0

WORKDIR /app

COPY ./cypress ./cypress
COPY ./cypress.json ./cypress.json

RUN npm i & npx cypress run --spec cypress/integration/pom/*.spec.js --headless --browser chrome