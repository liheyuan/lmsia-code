from locust import HttpLocust, TaskSet, task

import resource
resource.setrlimit(resource.RLIMIT_NOFILE, (999999, 999999))
print resource.getrlimit(resource.RLIMIT_NOFILE)

class TestSet(TaskSet):
    @task(2)
    def hello(self):
        self.client.get("/lmsia-abc/api/")

class WebsiteUser(HttpLocust):
    task_set = TestSet
    min_wait = 0
    max_wait = 0
