"""
vue-poc performance locust script
@author Andy Bunce
@since 2017-08-03
"""
from locust import HttpLocust, TaskSet, task
auth=("ArcadianUser","**password**")
user={"username":"admin", "password":"uksapl"}
class UserBehavior(TaskSet):



	# images  
    @task(2)
    def images(self):
        self.client.get("/vue-poc/api/images/list")
    
    @task(1)    
    def keyword(self):
        self.client.get("/vue-poc/api/images/list?page=0&from&keyword=albania", name="keyword=albania")		


class WebsiteUser(HttpLocust):
    host = "http://localhost:8984"
    task_set = UserBehavior
    min_wait = 5000
    max_wait = 10000