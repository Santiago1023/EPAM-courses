## Python tasks (API Gateway with lambda)

### Project Overview
This is a project that shows the way in which we can make a basic cloud project with Lambda and API Gateway.
I related the step by step in a [MEDIUM BLOG](https://medium.com/@santiago.bedoyad/how-can-we-make-our-first-cloud-project-2a22c18c0631 "MEDIUM BLOG") .

**Tools:**
- Cloud service (AWS Lambda, and API Gateway)
- Python
- NextJS
- Postman

### Architecture
The architecture of the application is described below:
- The users can interact with the API Gateway endpoints. When you enter the url in the browser or in a tool such as postman, it will run the lambda function and you can view the response.

![architecture.png](/specialization/apigateway-lambda/images/architecture.png)
### Project Structure
```
apigateway-lambda/ # Main directory
├── lambda-tasks/ # 3 tasks
│ ├── task1.py # Contains the solution to task 1
│ ├── task2.py # Contains the solution to task 2
│ ├── task3.py # Contains the solution to task 3
├── frontend/ # Next.js app
│ ├── src/ # App core
│ │ ├── page.js # Homepage js
│ │ ├── page.module.css # Homepage css
│ │ ├── global.css # Global styles
└── README.md # Overview of the project
```

### What I Learned
- Write medium blogs
- Describe my mindset or the way in how I can build cloud projects
- Learn AWS Lambda
- Learn API Gateway
- Connect or attach an endpoint of API Gateway to each lambda function

### Future Enhancements
- Troubleshooting with CORS errors:
1) I was not able to communicate the frotend with the api gateway, and I do not know how to fix it, so [I search some solutions](https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api-cors.html "I search some solutions"), but I obtained the same error:
![postman.png](/specialization/apigateway-lambda/images/postman.jpg)
![browser.png](/specialization/apigateway-lambda/images/browser.jpg)
