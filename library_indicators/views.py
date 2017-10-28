from .api_connections import RequestLibraryRawData
from .models import PercentLibraries
from .models import PercentPublicOrPrivateLibrary
from .models import PercentLibraryPerAreaOfActivity
from .models import QuantityOfRegisteredlibraries
from .models import PercentLibrariesTypeSphere
from django.shortcuts import render
import datetime

DEFAULT_INITIAL_DATE = "2012-01-01 15:47:38.337553"

def index(request):
    update_indicators()

    last_register_percent_private_library = PercentPublicOrPrivateLibrary.objects.count()
    percent_public_private = PercentPublicOrPrivateLibrary.objects[last_register_percent_private_library-1]

    last_register_quantity_libraries = QuantityOfRegisteredlibraries.objects.count()
    quantity_libraries = QuantityOfRegisteredlibraries.objects[last_register_quantity_libraries -1]

    last_register_type_sphere_quantity = PercentLibrariesTypeSphere.objects.count()
    type_sphere_total = PercentLibrariesTypeSphere.objects[last_register_type_sphere_quantity - 1]

    last_register_ocupation_area_quantity = PercentLibraryPerAreaOfActivity.objects.count()
    ocupation_area_total = PercentLibraryPerAreaOfActivity.objects[last_register_ocupation_area_quantity - 1]

    context = {
        'total_libraries': percent_public_private._total_libraries,
        'amount_public_libraries': percent_public_private._total_public_libraries,
        'amount_private_libraries': percent_public_private._total_private_libraries,
        'quantity_per_mouth': quantity_libraries._libraries_registered_monthly,
        'quantity_per_year': quantity_libraries._libraries_registered_yearly,
        'type_sphere_total': type_sphere_total._total_libraries_type_sphere,
        'ocupation_area_total':ocupation_area_total._libraries_per_activity,
        'amount_of_ocupation_area':ocupation_area_total._amount_areas,
    }
    return render(request, 'libraries_indicator/index.html', context)



def update_indicators():
    update_library_public_private_indicator()
    update_quantity_libraries()
    update_type_sphere_indicator()
    update_ocupation_area_indicator()

def update_library_public_private_indicator():
    if (len(PercentPublicOrPrivateLibrary.objects)== 0):
        PercentPublicOrPrivateLibrary(0, DEFAULT_INITIAL_DATE, 0, 0).save()
    else:
        undefined_library = 0
        public_libraries = 0
        private_libraries = 0
        total_libraries = 0
        undefined_library, public_libraries, private_libraries, total_libraries =  set_libraries_amount(undefined_library,
                             public_libraries, private_libraries, total_libraries)
        PercentPublicOrPrivateLibrary(total_libraries,
                                      datetime.datetime.now(),
                                      public_libraries, private_libraries).save()

def set_libraries_amount(undefined_library, public_libraries, private_libraries, total_libraries):
    undefined_library = get_undefined_library()
    public_libraries = get_public_libraries()
    private_libraries = get_private_libraries()
    total_libraries = undefined_library + public_libraries + private_libraries
    return undefined_library, public_libraries, private_libraries, total_libraries

def update_quantity_libraries():
    if (len(QuantityOfRegisteredlibraries.objects) == 0):
        QuantityOfRegisteredlibraries(0, DEFAULT_INITIAL_DATE, {'julho':10}, {'2010':2}).save()
    else:
        undefined_library = 0
        public_libraries = 0
        private_libraries = 0
        total_libraries = 0
        year_libraries = {}
        mouth_libraries = {}
        get_libraries_per_year(year_libraries)
        get_libraries_per_month(mouth_libraries)
        set_libraries_amount(undefined_library,
                             public_libraries, private_libraries, total_libraries)
        QuantityOfRegisteredlibraries(total_libraries,
                                      datetime.datetime.now(),
                                      mouth_libraries, year_libraries).save()

def update_type_sphere_indicator():
    if (len(PercentLibrariesTypeSphere.objects)== 0):
        PercentLibrariesTypeSphere(0, DEFAULT_INITIAL_DATE,{'Municipal': 1}).save()
    else:
        total_libraries = get_public_libraries() + get_private_libraries() + get_undefined_library()
        type_sphere_total = get_all_type_sphere()
        PercentLibrariesTypeSphere(total_libraries,
                                    datetime.datetime.now(),
                                    type_sphere_total).save()

def update_ocupation_area_indicator():
    if (len(PercentLibraryPerAreaOfActivity.objects)== 0):
        PercentLibraryPerAreaOfActivity(0, DEFAULT_INITIAL_DATE,{'Leitura': 1},0).save()
    else:
        ocupation_area_total = get_all_occupation_area()
        amount_ocupation_area = len(ocupation_area_total)
        total_libraries = get_public_libraries() + get_private_libraries() + get_undefined_library()
        PercentLibraryPerAreaOfActivity(total_libraries,
                                        datetime.datetime.now(),
                                        ocupation_area_total,
                                        amount_ocupation_area).save()

def get_all_libraries():
    request = RequestLibraryRawData(DEFAULT_INITIAL_DATE)
    libraries = request.data
    return libraries

def get_public_libraries():
    count = 0
    for librarie in get_all_libraries():
        if librarie["esfera"] != None and librarie["esfera"] == 'Pública':
            count = count + 1
    return count

def get_private_libraries():
    count = 0

    for librarie in get_all_libraries():
        if librarie["esfera"] != None and librarie["esfera"] == 'Privada':
            count = count + 1
    return count


def get_undefined_library():
    count = 0
    for librarie in get_all_libraries():
        if( librarie["esfera"] == None ):
            count = count + 1
    return count


def get_all_occupation_area():
    areas = {}
    count = 0
    for librarie in get_all_libraries():
        for area in librarie["terms"]["area"]:
            count = filter_types_area(area, areas)
    return areas

#return dictionary with value of each area
def filter_types_area(actual_area, areas):
    if not (actual_area in areas):
        areas[actual_area] = 1
    else:
        areas[actual_area] += 1


def get_libraries_per_year(create_date_year):
    for librarie in get_all_libraries():
        date = format_date_year(librarie["createTimestamp"]["date"])
        filter_libraries_per_year(create_date_year,date)

def format_date_year(date):
    right_date = date.split(" ")
    year_date = right_date[0].split("-")
    return year_date[0]

def filter_libraries_per_year(create_dates, date):
    if not (date in create_dates):
        create_dates[date] = 1
    else:
        create_dates[date] += 1

def format_date_month(date):
    right_date = date.split(" ")
    month_date = right_date[0].split("-")
    return month_date[1]

def get_libraries_per_month(create_date_month):

    for librarie in get_all_libraries():
        date = format_date_month(librarie["createTimestamp"]["date"])
        filter_libraries_per_month(create_date_month, date)


def filter_libraries_per_month(create_date_month, month):
    if not (month in create_date_month):
        create_date_month[month] = 1
    else:
        create_date_month[month] += 1

def get_all_type_sphere():
    per_type = {}
    per_type['None'] = 1
    for library in get_all_libraries():
        filter_sphere_type(per_type, library)
    return per_type

def filter_sphere_type(per_type, library):
    if(library["esfera_tipo"] != None):
        if not (library["esfera_tipo"] in per_type):
            per_type[library["esfera_tipo"]] = 1
        else:
            per_type[library["esfera_tipo"]] += 1
    else:
        per_type['None'] += 1
