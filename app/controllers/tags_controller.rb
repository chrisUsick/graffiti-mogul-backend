class TagsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  def create
    attributes = tags_params
    lonlat = attributes.delete :lonlat
    tag = current_user.tags.build(attributes)
    tag.location = "POINT(#{lonlat[:lon].to_f} #{lonlat[:lat].to_f})"
    p tag.location
    if tag.save
      render status: 200
    else
      render status: 400, json: tag.errors
    end
  end

  def find
    lat, lon = params[:lat], params[:lon]
    p lat,lon
    # render json: Tag.order('<-> st_setsrid(st_makepoint(:lon :lat),4326)', lon: lon, lat: lat).limit(10)
    # render json: Tag.where('<-> st_setsrid(st_makepoint(:lon :lat),4326)', lon: lon, lat: lat).limit(10)
    # "ST_DWithin(tags.location, ST_GeographyFromText('SRID=4326;POINT(:lon :lat)'), 50000)"
    render json: Tag.find_by_sql(
      "SELECT * from tags ORDER BY location <-> st_setsrid(st_makepoint(#{lon.to_f},#{lat.to_f}),4326)"
    )
  end

  def show
    id = params[:id]
    render json: Tag.find(id)
  end

  private

  def tags_params
    params.require(:tag).permit(:title, :thumbnail).tap do |whitelisted|
      whitelisted[:lonlat] = params[:lonlat]
    end
  end
end
