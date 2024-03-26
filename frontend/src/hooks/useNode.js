import {useEffect, useState} from "react";
import axios from "axios";

const useNode = () => {
    const [nodes, setNodes] = useState([])
    const [links, setLinks] = useState([])

    useEffect(() => {
        async function initialSet() {
            const initNodes = await getNodes();
            const initTopologies = await getLinks();
            setNodes(initNodes.slice(0, 15));
            setLinks(initTopologies.slice(0, 15));
        }

        initialSet().then(r => {});
    }, []);

    const getNodes = async () => {
        const response = await axios.get(`https://service-gis-6qs3wm6dcq-uc.a.run.app/topology`);
        return response.data.geolocations;
    }

    const getLinks = async () => {
        const response = await axios.get(`https://service-gis-6qs3wm6dcq-uc.a.run.app/topology`);
        // console.log(response)
        return response.data.topology;
    }

    return {nodes, setNodes, links, setLinks, getNodes, getLinks}
}
export {useNode};