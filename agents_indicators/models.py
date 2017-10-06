# from django.db import models
from mongoengine import Document
from mongoengine import DictField
from mongoengine import IntField
from mongoengine import DateTimeField



class PercentAgents(Document):
    _total_agents = IntField(required=True)
    _create_date = DateTimeField(required=True)

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

class PercentAgentsState(Document):
    _total_agents_for_state = DictField(required=True)
    _create_date = DateTimeField(required=True)

    @property
    def total_agents_for_state(self):
        return self._total_agents_for_state

    @total_agents_for_state.setter
    def total_agents_for_state(self, number):
        self._total_agents_for_state = number

    @property
    def create_date(self):
        return self._create_date

    @create_date.setter
    def create_date(self, number):
        self._create_date = number

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



# Amount of agents registered per year on the platform throughout its existence
class AmountAgentsRegisteredPerYear(Document):
    _totalAgentsRegisteredPerYear = DictField(required=True)
    _createDate = DateTimeField(required=True)

    @property
    def total_agents_registered_per_year(self):
        return self._totalAgentsRegisteredPerYear

    @total_agents_registered_per_year.setter
    def total_agents_registered_per_year(self, number):
        self._totalAgentsRegisteredPerYear = number

    @property
    def create_date(self):
        return self._createDate


    @create_date.setter
    def create_date(self, number):
        self._createDate = number


# Number of agents registered monthly on the platform throughout its existence
class AmountAgentsRegisteredPerMonth(Document):
    _totalAgentsRegisteredPerMonth = DictField(required=True)
    _createDate = DateTimeField(required=True)

    @property
    def total_agents_registered_per_month(self):
        return self._totalAgentsRegisteredPerMonth

    @total_agents_registered_per_month.setter
    def total_agents_registered_per_month(self, number):
        self._totalAgentsRegisteredPerMonth = number

    @property
    def create_date(self):
        return self._createDate

    @create_date.setter
    def create_date(self, number):
        self._createDate = number


class PercentAgentsPerAreaOperation(PercentAgents):
    _total_agents_area_oreration = DictField(required=True)

    @property
    def total_agents_area_oreration(self):
        return self._total_agents_area_oreration

    @total_agents_area_oreration.setter
    def total_agents_per_area_oreration(self, number):
        self._total_agents_area_oreration = number



# -------------------- state indicators --------------------------------
class PercentAgentsForState(PercentAgents):
    _total_agents_for_states = DictField(required=True)

    @property
    def total_agents_for_states(self):
        return self._total_agents_for_states

    @total_agents_for_states.setter
    def total_agents_for_states(self, number):
        self._total_agents_for_states = number


class PercentAgentsPerAreaOperationForState(PercentAgentsState):
    _total_agents__operation_state = DictField(required=True)

    @property
    def total_agents__operation_state(self):
        return self._total_agents__operation_state

    @total_agents__operation_state.setter
    def total_agents__operation_state(self, number):
        self._total_agents__operation_state = number


class PercentIndividualAndCollectiveAgentForState(PercentAgentsState):
    _total_individual_agent_state = DictField(required=True)
    _total_collective_agent_state = DictField(required=True)

    @property
    def total_individual_agent_state(self):
        return self._total_individual_agent_state

    @total_individual_agent_state.setter
    def total_individual_agent_state(self, number):
        self._total_individual_agent_state = number

    @property
    def total_collective_agent_state(self):
        return self._total_collective_agent_state

    @total_collective_agent_state.setter
    def total_collective_agent_state(self, number):
        self._total_collective_agent_state = number

    @property
    def total_agents_for_state(self):
        return self._totalAgentsForState

    @total_agents_for_state.setter
    def total_agents_for_state(self, number):
        self._totalAgentsForState = number

    @property
    def create_date(self):
        return self._createDate

    @create_date.setter
    def create_date(self, number):
        self._createDate = number
