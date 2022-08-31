// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/**
 * @title Integridad de archivos
 * @dev Guardar y recuperar hash de archivos
 */
contract Integridad {

    // uint256 para hash (originalmente usabamos String)
    // La implementacion se encargará de convertir valor hex (resultado de sha256) a uint
    // Para que elcontrato sea mas cost-effective
    mapping (uint256 => uint256) private fileHashes;

    /**
     * @dev Guardar Hash para un archivo dado su Identificador
     * @param id Identificador del archivo
     * @param hash Hash del archivo
     */
    function storeHash(uint256 id, uint256 hash) public {
        fileHashes[id] = hash;
    }

    /**
     * @dev Devuelve el hash de un archivo dado su Identificador
     * @return hash valor de hash para el archivo 'id'
     */
    function retrieveHash(uint256 id) public view returns (uint256){
        return fileHashes[id];
    }

    /**
     * @dev Almacena multiples hash para varios archivos
     * Como la implementacion requiere vincular los hash a un identificador unico (requerimiento del negocio) se
     * esperan 2 colecciones, una con los hashes, y la otra con los id's de los archivos hasheados
     */
    function storeHashMulti( uint256[] memory idList, uint256[] memory hashList ) public {
        uint256 i = 0;
        uint256 max = idList.length;
        while ( i<max )
        {
            // Guardo el hash de cada archivo de la coleccion
            storeHash (idList[i], hashList[i]);

            i++;
        }
    }

    /**
    * No se utilizan eventos porque la implementacion no requiere ni recomienda administrar informacion sobre los bloques de la blockchain que contienen la informacion;
    * ni tampoco divulgar ningun otro aspecto de la implementacion de este metodo de validacion de integridad de archivos.
    **/

     
}