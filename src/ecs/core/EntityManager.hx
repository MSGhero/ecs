package ecs.core;

import haxe.ds.Vector;

class EntityManager
{
    final storage : Vector<Entity>;
    final recycleBin : Vector<Int>;

    var nextID : Int;
    var binSize : Int;

    public function new(_max)
    {
        storage = new Vector(_max);
        nextID  = 0;
	   
	   recycleBin = new Vector(_max);
	   binSize = 0;
    }

    public function create()
    {
        if (binSize > 0)
	   {
		  // if concerned about double destroying an ent screwing this up, sparseset would be better
	       return storage[recycleBin[--binSize]];
	   }
	   
	   else
	   {
	       final idx = nextID++;
            final e   = new Entity(idx);

            storage[idx] = e;

            return e;
	   }
    }
    
    public function destroy(_id : Int)
    {
        recycleBin[binSize++] = _id;
    }

    public function get(_id : Int)
    {
        return storage[_id];
    }

    public function capacity()
    {
        return storage.length;
    }
}