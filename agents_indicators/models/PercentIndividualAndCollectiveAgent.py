# from django.db import models
from mongoengine import Document
from mongoengine import DictField
from mongoengine import IntField
from mongoengine import DateTimeField


# Percentage of individual and collective agents
class PercentIndividualAndCollectiveAgent(Document):
    _totalIndividualAgent = IntField(required=True)
    _totalCollectiveAgent = IntField(required=True)
    _totalAgents = IntField(required=True)
    _createDate = DateTimeField(required=True)

    @property
    def total_individual_agent(self):
        return self._totalIndividualAgent

    @total_individual_agent.setter
    def total_individual_agent(self, number):
        self._totalIndividualAgent = number

    @property
    def total_collective_agent(self):
        return self._totalCollectiveAgent

    @total_collective_agent.setter
    def total_collective_agent(self, number):
        self._totalCollectiveAgent = number

    @property
    def total_agents(self):
        return self._totalAgents

    @total_agents.setter
    def total_agents(self, number):
        self._totalAgents = number

    @property
    def create_date(self):
        return self._createDate

    @create_date.setter
    def create_date(self, number):
        self._createDate = number
