package away3d.core.pool {
	import away3d.core.base.SubGeometryBase;

	public class IndexDataPool {
		private static const _pool:Object = {};

		public function IndexDataPool() {
		}

		public static function getItem(subGeometry:SubGeometryBase, level:uint, indexOffset:uint):IndexData {
			var subGeometryData:Vector.<IndexData> = IndexDataPool._pool[subGeometry.id] || (IndexDataPool._pool[subGeometry.id] = new Vector.<IndexData>());

			var indexData:IndexData = subGeometryData[level] || (subGeometryData[level] = new IndexData(level));
			indexData.updateData(indexOffset, subGeometry.indices, subGeometry.numVertices);

			return indexData;
		}

		public static function disposeItem(id:uint, level:Number):void {
			var subGeometryData:Vector.<IndexData> = _pool[id];
			subGeometryData[level].dispose();
			subGeometryData[level] = null;
		}

		public static function disposeData(id:String):void {
			var subGeometryData:Vector.<IndexData> = _pool[id];

			var len:uint = subGeometryData.length;
			for (var i:uint = 0; i < len; i++) {
				subGeometryData[i].dispose();
				subGeometryData[i] = null;
			}
			_pool[id] = null;
		}
	}

}