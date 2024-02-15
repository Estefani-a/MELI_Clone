//
//  MockRepository.swift
//  AppIosW6CodePatroll_Example
//
//  Created by Estefania Sassone on 13/10/2022.
//  Copyright © 2022 MercadoLibre. All rights reserved.
//

import Foundation
class MockService: RepositoryProtocol {

    

    func getItems(categoryId: String, completion: @escaping (Result<ListModel, CustomError>) -> Void) {
        let mockedlist: ListModel = loadJSONFrom("MotorcycleMockedList.json")
        completion(.success(mockedlist))
    }
    
    func getItemDescription(itemId: String, completion: @escaping (Result<String, CustomError>) -> Void) {
        completion(.success("K´1000 MOTOS\nCONCESIONARIO OFICIAL PREMIUM\nCFMOTO - BENELLI - ZANELLA - MOTOMEL – KEEWAY - SYM \n\nLLEVÁ TU CFMOTO RZ 300 TARJETA 12 CUOTAS SIN INTERÉS - TASA 0% - HASTA $350.000\nCRÉDITOS PRENDARIOS BBVA\nTARJETAS - AHORA 12/18\nTOMAMOS DÓLARES\nTOMAMOS TU MOTO EN PARTE DE PAGO\nCONSULTÁ PRECIO DE CONTADO\nCONSULTÁ POR TODAS LAS FINANCIACIONES\nTODOS LOS MEDIOS DE PAGO\n-------------------------------------------------------------------------\nServicio de Gestoría\nSeguros – Todas las coberturas\nServicio de Atención al Cliente - Posventa y Garantía\nServicio Técnico Oficial Especializado\nRepuestos Originales y Accesorios\nColocación de accesorios en la entrega\n-------------------------------------------------------------------------\nCréditos con sólo el DNI – Tarjetas Ahora 12/18\nCréditos prendarios a través del BBVA\nTomamos tu usado – Tomamos Dólares\nConsultá por todas las Financiaciones\n-------------------------------------------------------------------------\nTodos los Medios de Pago – Tarjetas de Crédito\nDébito – Efectivo – Transferencia Bancaria\nMercado Pago – Reservas por Mercado Libre\n-------------------------------------------------------------------------\nSERVICE OFICIAL:\nSERVICE OFICIAL Y GARANTÍA: BENELLI - MOTOMEL - KEEWAY - ZANELLA - CFMOTO - SYM\nContamos con personal mecánico de amplia experiencia para atenderte, asesorarte y colaborar para la solución de todo lo relacionado con tu moto. Centro de servicio autorizado para realizar el service que tu vehículo requiere. Realizá con nosotros el mantenimiento de tu moto con repuestos originales y mecánicos especializados.\nSERVICIO DE GESTORÍA: \nRealizá el patentamiento de tu moto con nosotros. Retirá tu moto en el acto con un permiso provisorio para circular por 30 días, hasta que llegue tu patente y cédula.\nSEGUROS:\nTrabajamos con las mejores aseguradoras: ATM o Triunfo Seguros y con todas las coberturas\nTIENDA DE ACCESORIOS:\nCascos, camperas, lingas, guantes, lubricantes y todo lo que necesitás para vivir la mejor experiencia con tu moto.\nREPUESTOS ORIGINALES:\nTodos los repuestos y marcas\n\nCONTAMOS CON SUCURSALES EN CABA Y GBA CON MÁS DE 200 MOTOS EN EXHIBICIÓN"))
    }
    
    func getItemPictures(itemId: String, completion: @escaping (Result<ItemPicturesModel, CustomError>) -> Void) {
        abort()
    }
    
    func store(_ model: ListModel, callback: @escaping () -> Void) {
    }
    
}
