from mongoengine import Document
from mongoengine import DictField
from mongoengine import IntField
from mongoengine import StringField


class PercentAgents(Document):
    class Meta:
        abstract = True
    meta = {'allow_inheritance': True}
    _total_agents = IntField(required=True)
    _create_date = StringField(required=True)

    @property
    def create_date(self):
        return self._create_date

    @create_date.setter
    def create_date(self, number):
        self._create_date = number

    @property
    def total_agents(self):
        return self._total_agents

    @total_agents.setter
    def total_agents(self, number):
        self._total_agents = number


# Percentage of individual and collective agents
class PercentIndividualAndCollectiveAgent(PercentAgents):
    _total_individual_agent = IntField(required=True)
    _total_collective_agent = IntField(required=True)

    @property
    def total_individual_agent(self):
        return self._total_individual_agent

    @total_individual_agent.setter
    def total_individual_agent(self, number):
        self._total_individual_agent = number

    @property
    def total_collective_agent(self):
        return self._total_collective_agent

    @total_collective_agent.setter
    def total_collective_agent(self, number):
        self._total_collective_agent = number


# Number of agents registered monthly on the platform throughout its existence
class AmountAgentsRegisteredPerMonth(Document):
    _total_agents_registered_month = DictField(required=True)
    _create_date = StringField(required=True)

    @property
    def total_agents_registered_month(self):
        return self._total_agents_registered_month

    @total_agents_registered_month.setter
    def total_agents_registered_month(self, number):
        self._total_agents_registered_month = number

    @property
    def create_date(self):
        return self._create_date

    @create_date.setter
    def create_date(self, number):
        self._create_date = number


class PercentAgentsPerAreaOperation(PercentAgents):
    _total_agents_area_oreration = DictField(required=True)

    @property
    def total_agents_area_oreration(self):
        return self._total_agents_area_oreration

    @total_agents_area_oreration.setter
    def total_agents_per_area_oreration(self, number):
        self._total_agents_area_oreration = number
