FROM cypress/included:4.1.0

WORKDIR /app

COPY ./cypress ./cypress
COPY ./cypress.json ./cypress.json

RUN npm i & npx cypress run --headless --browser chrome