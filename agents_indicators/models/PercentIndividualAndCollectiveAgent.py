# from django.db import models
from mongoengine import Document
from mongoengine import IntField
from mongoengine import DateTimeField

# Percentage of individual and collective agents
class PercentIndividualAndCollectiveAgent(Document):
    _total_individual_agent = IntField(required=True)
    _total_collective_agent = IntField(required=True)
    _total_agents = IntField(required=True)
    _create_date = DateTimeField(required=True)


    @property
    def total_individual_agent(self):
        return self._total_individual_agent

    @total_individual_agent.setter
    def total_individual_agent(self, number):
        self._total_individual_agent = number

    @property
    def get_total_collective_agent(self):
        return self._total_collective_agent


    @total_collective_agent.setter
    def total_collective_agent(self, number):
        self._total_collective_agent = number

    @property
    def total_agents(self):
        return self._total_agents

    @total_agents.setter
    def total_agents(self, number):
        self._total_agents = number

    @property
    def create_date(self):
        return self._create_date

    @create_date.setter
    def create_date(self, number):
        self._create_date = number
