package dao;

import java.util.List;

import metier.Region;

public interface IRegionCRUD {

	void createRegion (Region  region);
	
	void deleteRegion (Long id);
	
	Region updateRegion (Region  region);
	
	Region getById(Long id);
	
	List<Region> getAll();
	
	Region getRegionByCitoyen(Long idCitoyen);
}
