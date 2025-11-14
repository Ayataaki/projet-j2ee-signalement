package servlet.draft;

import java.util.List;

import dao.IRegionCRUD;
import dao.RegionCRUDImpl;
import metier.Region;

public class TestRegion {

	public static void main(String[] args) {

		final IRegionCRUD regionDao = new RegionCRUDImpl();
    	List<Region> regions = regionDao.getAll();
    	for (Region reg : regions) {
    	    System.out.println(reg.getIdRegion());
    	}


	}

}
