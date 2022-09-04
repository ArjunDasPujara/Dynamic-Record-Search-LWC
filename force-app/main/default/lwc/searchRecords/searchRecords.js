import { LightningElement, track } from 'lwc';
import getSearchableObjectListApex from '@salesforce/apex/SearchRecordController.getSearchableObjectList';
import getFieldListBySObjectApiNameApex from '@salesforce/apex/SearchRecordController.getFieldListBySObjectApiName';
import selectBySearchTearmAndSearchFieldApex from '@salesforce/apex/SearchRecordController.selectBySearchTearmAndSearchField';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

const ERROR_TOST = 'error';

export default class SearchRecords extends LightningElement {

	data = [];
	fieldApiName;
	isContentReady = false;
	isError = false;
	isLoding = true;
	objectApiName;
	objectApiNameForWhichFieldListIsAvailabel = new Set();
	objectOptions = [];

	@track
	_fieldOptions = {};

	@track
	_dataTableFields = {};

	async connectedCallback() {
		await this.getSearchableObjectList();
	}

	getFieldList() {
		this.isLoding = true;
		getFieldListBySObjectApiNameApex({
			sobjectApiName : this.objectApiName
		}).then(result => {
			let fieldOptiondata = [];
			let tableMetadata = [];
			result.forEach((element) => {
				fieldOptiondata.push({label : element.label, value : element.value});
				tableMetadata.push({label : element.label, fieldName : element.value});
			});
			this._fieldOptions[this.objectApiName] = fieldOptiondata;
			this._dataTableFields[this.objectApiName] = tableMetadata;
		}).catch(() => {
			this.isError = true;
		}).finally(()=> {
			if(!this.isError) {
				this.isContentReady = true;
			}
			this.isLoding = false;
		});
	}

	async getSearchableObjectList() {
		getSearchableObjectListApex().then(result => {
			this.objectOptions = [...result];
		}).catch(() => {
			this.isError = true;
		}).finally(() => {
			this.isLoding = false;
			if(!this.isError) {
				this.isContentReady = true;
			}
		});
	}

	handleFieldChange(event) {
		this.fieldApiName = event.detail.value;
	}

	handleObjectChange(event) {
		this.objectApiName = event.detail.value;
		this.fieldApiName = null;
		this.data = [];
		if(!this.objectApiNameForWhichFieldListIsAvailabel.has(this.objectApiName)) {
			this.getFieldList();
		}
	}

	handleSearch(event) {
		if(!this.objectApiName) {
			this.showNotification('Error', 'Please select object for search', ERROR_TOST);
			return;
		}

		if(!this.fieldApiName) {
			this.showNotification('Error', 'Please select Field for search', ERROR_TOST);
			return;
		}

		let fieldList = [];
		this.data = [];

		this.isLoding = true;
		this.isContentReady = false;

		this._dataTableFields[this.objectApiName].forEach((element)=>{
			fieldList.push(element.fieldName);
		});
		
		selectBySearchTearmAndSearchFieldApex({
			sobjectName: this.objectApiName,
			searchTerm: event.detail.searchTerm,
			searchField : this.fieldApiName,
			fieldList : fieldList
		}).then(result => {
			this.data = [...result]
		}).catch(() => {
			this.isError = true;
		}).finally(()=> {
			this.isLoding = false;
			if(!this.isError) {
				this.isContentReady = true;
			}
		});
	}

	showNotification(title, message, variant) {
		const event = new ShowToastEvent({
			title: title,
			message: message,
			variant: variant,
		});
		this.dispatchEvent(event);
	}

	get dataTableFields() {
		console.log(this._dataTableFields[this.objectApiName]);
		return this._dataTableFields[this.objectApiName];
	}

	get fieldOptions() {
		console.log(this._fieldOptions[this.objectApiName]);
		return this._fieldOptions[this.objectApiName];
	}
}