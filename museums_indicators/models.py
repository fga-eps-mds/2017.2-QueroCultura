from mongoengine import Document
from mongoengine import DictField
from mongoengine import IntField
from mongoengine import StringField

# -------------------- state indicators --------------------------------

class PercentMuseums(Document):
    class Meta:
        abstract = True
    meta = {'allow_inheritance': True}
    _total_museums = IntField(required=True)
    _create_date = StringField(required=True)

    @property
    def total_museums(self):
        return self._total_museums

    @total_museums.setter
    def total_museums(self, number):
        self._total_museums = number

    @property
    def create_date(self):
        return self._create_date

    @create_date.setter
    def create_date(self, number):
        self._create_date = number


class PercentThematicsMuseums(PercentMuseums):
    _thematics_museums = DictField(required=True)

    @property
    def thmeatics_museums(self):
        return self._thematics_museums

    @thmeatics_museums.setter
    def thmeatics_museums(self, number):
        self._thematics_museums = number



class PercentTypeMuseums(PercentMuseums):
    _type_museums = DictField(required=True)

    @property
    def type_museums(self):
        return self._type_museums

    @type_museums.setter
    def type_museums(self, number):
        self._type_museums = number


class PercentPublicOrPrivateMuseums(PercentMuseums):
    _total_public_private_museums = DictField(required=True)
    
    @property
    def total_public_private_museums(self):
        return self._total_public_private_museums

    @total_public_private_museums.setter
    def total_public_private_museums(self, number):
        self._total_public_private_museums = number

class AmountMuseumsRegisteredYear(Document):
    _total_museums_registered_year = DictField(required=True)
    _create_date = StringField(required=True)

    @property
    def total_museums_registered_year(self):
        return self._total_museums_registered_year

    @total_museums_registered_year.setter
    def total_museums_registered_year(self, number):
        self._total_museums_registered_year = number

    @property
    def create_date(self):
        return self._create_date

    @create_date.setter
    def create_date(self, number):
        self._create_date = number

class PercentMuseumsPromoteGuidedTour(PercentMuseums):
    _total_museums_promote_guide = DictField(required=True)

    @property
    def total_museums_promote_guide(self):
        return self._total_museums_promote_guide

    @total_museums_promote_guide.setter
    def total_museums_promote_guide(self, number):
        self._total_museums_promote_guide = number
        
class PercentMuseumsHistoricalArchivePublicAccess(PercentMuseums):
    _total_museums_historical = DictField(required=True)

    @property
    def total_museums_historical(self):
        return self._total_museums_historical

    @total_museums_historical.setter
    def total_museums_historical(self, number):
        self._total_museums_historical = number
