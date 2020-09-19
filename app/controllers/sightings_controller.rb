class SightingsController < ApplicationController
    def show
        sighting = Sighting.find_by(id: params[:id])
        if sighting
            render json: sighting, include: [:bird, :location], except: [:updated_at, :created_at]
        else
            render json: {message: 'No sighting found with that id'}
        end
    end
end


# EXAMPLE - syntax render json: sighting
# def show
#     sighting = Sighting.find_by(id: params[:id])
#     render json: sighting
# end
# returns:
# {
#     "id": 1,
#     "bird_id": 1,
#     "location_id": 2,
#     "created_at": "2020-09-19T21:23:52.649Z",
#     "updated_at": "2020-09-19T21:23:52.649Z"
# }
# !EXAMPLE - 

# EXAMPLE - syntax render json: {id: sighting.id, bird: sighting.bird, location: sighting.location}
# def show
#     sighting = Sighting.find_by(id: params[:id])
#     render json: {id: sighting.id, bird: sighting.bird, location: sighting.location}
# end
# returns:
# {
#     "id": 1,
#     "bird": {
#         "id": 1,
#         "name": "Black-Capped Chickadee",
#         "species": "Poecile Atricapillus",
#         "created_at": "2020-09-19T21:23:52.594Z",
#         "updated_at": "2020-09-19T21:23:52.594Z"
#     },
#     "location": {
#         "id": 2,
#         "latitude": 30.26715,
#         "longitude": "-97.74306",
#         "float": null,
#         "created_at": "2020-09-19T21:23:52.614Z",
#         "updated_at": "2020-09-19T21:23:52.614Z"
#     }
# }
# !EXAMPLE - 

# EXAMPLE - render json: sighting, include: [:bird, :location]
# altSyntax: render json: sighting, include: [:bird, :location] =>> gives back all attributes of the objects passed in the argument ([:bird, :location]) as embedded parts of the json return
# returns: 
# {
#     "id": 1,
#     "bird_id": 1,
#     "location_id": 2,
#     "created_at": "2020-09-19T21:23:52.649Z",
#     "updated_at": "2020-09-19T21:23:52.649Z",
#     "bird": {
#         "id": 1,
#         "name": "Black-Capped Chickadee",
#         "species": "Poecile Atricapillus",
#         "created_at": "2020-09-19T21:23:52.594Z",
#         "updated_at": "2020-09-19T21:23:52.594Z"
#     },
#     "location": {
#         "id": 2,
#         "latitude": 30.26715,
#         "longitude": "-97.74306",
#         "float": null,
#         "created_at": "2020-09-19T21:23:52.614Z",
#         "updated_at": "2020-09-19T21:23:52.614Z"
#     }
# }
# !EXAMPLE - 

# EXAMPLE - render json: removing attributes from return object. 
# syntax: render json: sighting, include: [:bird, :location], except: [:updated_at, :created_at] 
# =>> removes the attributes given to except: from the main return object (and does NOT remove those attributes from the objects passed as arguments to :include)
# returns:
# {
#     "id": 1,
#     "bird_id": 1,
#     "location_id": 2,
#     "bird": {
#     "id": 1,
#     "name": "Black-Capped Chickadee",
#     "species": "Poecile Atricapillus",
#     "created_at": "2020-09-19T21:23:52.594Z",
#     "updated_at": "2020-09-19T21:23:52.594Z"
#     },
#     "location": {
#     "id": 2,
#     "latitude": 30.26715,
#     "longitude": "-97.74306",
#     "float": null,
#     "created_at": "2020-09-19T21:23:52.614Z",
#     "updated_at": "2020-09-19T21:23:52.614Z"
#     }
# }
# syntax:render json: sighting.to_json(:include => {:bird => {:only => [:name, :species]}, :location => {:only => [:latitude, :longitude]}}, :except => [:updated_at])
# =>> removes the attributes from the embedded objects specified in :include as arguments
# returns: 
# {
#     "id": 2,
#     "bird_id": 2,
#     "location_id": 2,
#     "created_at": "2019-05-14T11:20:37.228Z",
#     "bird": {
#       "name": "Grackle",
#       "species": "Quiscalus Quiscula"
#     },
#     "location": {
#       "latitude": 30.26715,
#       "longitude": -97.74306
#     }
# }
# !EXAMPLE - 