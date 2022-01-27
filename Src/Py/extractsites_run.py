#!/usr/bin/python
#imports
from qgis.core import *
from qgis.analysis import QgsGeometryAnalyzer
from osgeo import gdal
import processing
import numpy
#Paths
vlayer_path = "/Volumes/WCCDefiant/Academia/Projects/Alaska/Data/GIS/Vector/Sites/AHRS_sites_pre10.shp"
rlayer_path = "/Volumes/WCCDefiant/Academia/Projects/Alaska/Data/GIS/Raster/Stack/tanana_pca_rnd_clp.tif"
temp_path = "/Volumes/WCCDefiant/Academia/Projects/Alaska/Data/GIS/Temp/"
xyz_out_path = "/Volumes/WCCDefiant/Academia/Projects/Alaska/Data/GIS/known_sites_pre10.csv"
#variables
buff_size = 500
#load vlayer
vlayer = iface.addVectorLayer(vlayer_path, "sites", "ogr")
#if not vlayer:
#    print "Layer failed to load!"
#load rlayer(s)
rlayer = iface.addRasterLayer(rlayer_path, "raster input")
#if not rlayer.isValid():
#    print "Layer failed to load!"
#create file object for saving data
f=open(xyz_out_path,"a")
#loop over features (points) to extract raster data
iterfeatures = vlayer.getFeatures()
#column number in the attribute table to use as feat.id below---must be INT
featureid = 9
for feat in iterfeatures:
    vlayer.select(feat.id())
    buff_path = temp_path + "tempbuff.shp"
    clipped_rlayer_path = temp_path + "temprast" + str(feat[featureid]) + ".tif"
    QgsGeometryAnalyzer().buffer(vlayer,
                                 buff_path,
                                 buff_size,
                                 True,
                                 False,
                                 -1)
    processing.runalg("gdalogr:cliprasterbymasklayer",
        rlayer_path,
        buff_path,
        -9999,
        False,
        True,
        True,
        5,
        0,
        1,
        1,
        1,
        False,
        0,
        "",
        False,
        clipped_rlayer_path)
    vlayer.deselect(feat.id())
    clipped_rlayer = gdal.Open(clipped_rlayer_path)
    #(upper_left_x, x_size, x_rotation, upper_left_y, y_rotation, y_size) = r.GetGeoTransform()
    geospatialinfo = clipped_rlayer.GetGeoTransform()
    rdims = (clipped_rlayer.RasterXSize, clipped_rlayer.RasterYSize)
    nbands = clipped_rlayer.RasterCount
    npixels = numpy.product(rdims)
    clipped_rlayer_array = clipped_rlayer.ReadAsArray()
    dx = numpy.round(geospatialinfo[1])
    dy = numpy.round(geospatialinfo[5])
    x_min = geospatialinfo[0]
    x_max = geospatialinfo[0]+(dx*(rdims[0]))
    y_max = geospatialinfo[3]
    y_min = geospatialinfo[3]+(dy*(rdims[1]-1))
    site_id = numpy.repeat(feat[featureid],npixels)
    xcoords = numpy.arange(x_min,x_max,geospatialinfo[1])
    ycoords = numpy.arange(y_max,y_min,geospatialinfo[5])
    rcoords = numpy.array([(y,x) for y in ycoords for x in xcoords])
    if nbands > 1:
        array_reshape = numpy.reshape(clipped_rlayer_array,(-1,npixels)).T
        xyz = numpy.column_stack((site_id,rcoords,array_reshape))
    else:
        xyz = numpy.column_stack((site_id,rcoords,numpy.reshape(clipped_rlayer_array,(1,-1)).T))
    numpy.savetxt(f,xyz,delimiter=",")
    clipped_rlayer=None
#next is to write (append) the xyz to a CSV file
f.close()
